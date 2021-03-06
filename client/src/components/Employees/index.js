import _ from 'lodash';
import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { hashHistory } from 'react-router';
import { translate } from 'react-i18next';
import * as actions from 'actions';
import LoadingScreen from 'components/LoadingScreen';
import SearchField from 'components/SearchField';
import ConfirmationModal from 'components/ConfirmationModal';
import StaffjoyButton from 'components/StaffjoyButton';
import { COMPANY_EMPLOYEE, getRoute } from 'constants/paths';
import CreateEmployeeModal from './CreateEmployeeModal';
import Table from './Table';
import * as rowTypes from './Table/Row/rowTypes';

require('./employees.scss');

class Employees extends React.Component {
  constructor(props) {
    super(props);
    this.handleShowModalClick = this.handleShowModalClick.bind(this);
    this.handleCancelModalClick = this.handleCancelModalClick.bind(this);
    this.handleDeleteEmployeeClick = this.handleDeleteEmployeeClick.bind(this);
  }

  componentDidMount() {
    const { dispatch } = this.props;

    // get the employees for the whole company
    dispatch(actions.initializeEmployees(this.props.companyUuid));
  }

  handleShowModalClick(uuid) {
    const { userUuid } = this.props;

    this.employeeUuidToDelete = uuid;

    if (userUuid === uuid) {
      this.errorModel.showModal();
    } else {
      this.modal.showModal();
    }
  }

  handleCancelModalClick() {
    const { userUuid } = this.props;

    if (userUuid === this.employeeUuidToDelete) {
      this.errorModel.hideModal();
    } else {
      this.modal.hideModal();
    }

    this.employeeUuidToDelete = null;
  }

  handleDeleteEmployeeClick() {
    const {
      companyUuid,
      deleteEmployee,
    } = this.props;

    const {
      employeeUuidToDelete,
    } = this;

    this.modal.hideModal();

    deleteEmployee(companyUuid, employeeUuidToDelete);

    this.employeeUuidToDelete = null;
  }

  render() {
    const {
      children,
      companyUuid,
      employees,
      isFetching,
      updateSearchFilter,
      teams,
      tableRowClicked,
      t,
    } = this.props;

    const columns = [
      {
        columnId: 'employees',
        colWidth: 4,
        translate: 'employees',
        component: rowTypes.PHOTO_NAME,
        propDataFields: {
          name: 'name',
          photoUrl: 'photo_url',
        },
      },
      {
        columnId: 'contact',
        colWidth: 3,
        translate: 'contact',
        component: rowTypes.CONTACT_INFO,
        propDataFields: {
          email: 'email',
          phoneNumber: 'phonenumber',
        },
      },
      // {
      //   columnId: 'team',
      //   colWidth: 3,
      //   displayName: 'Team',
      //   component: rowTypes.INFO_LIST,
      //   propDataFields: {
      //     name: 'name',
      //     photoUrl: 'photo_url',
      //   },
      // },
      // {
      //   columnId: 'status',
      //   colWidth: 2,
      //   displayName: 'Status',
      //   component: rowTypes.BOOLEAN_LABEL,
      //   propDataFields: {
      //     booleanField: 'confirmed_and_active',
      //   },
      //   callback(fieldValue) { return (fieldValue) ? 'Active' : 'Inactive'; },
      // },
    ];

    if (isFetching) {
      return (
        <LoadingScreen />
      );
    }

    // params have initialized if it's gotten this far

    return (
      <div className="employees">
        <div className="employees-container">
          <div className="employees-control-panel">
            <SearchField width={200} onChange={updateSearchFilter} />
            <div className="employees-control-panel-buttons">
              <CreateEmployeeModal companyUuid={companyUuid} teams={teams} />
            </div>
          </div>
          <div className="scrolling-panel">
            <Table
              columns={columns}
              rows={employees}
              onRowClick={tableRowClicked}
              uuidKeyName="user_uuid"
              handleShowModalClick={this.handleShowModalClick}
            />
          </div>
          <ConfirmationModal
            ref={(modal) => { this.modal = modal; }}
            title={t('confirmation')}
            content={t('msg.jobs_deleted')}
            buttons={[
              <StaffjoyButton
                buttonType="outline"
                size="tiny"
                key="cancel-button"
                onClick={this.handleCancelModalClick}
              >
                {t('cancel')}
              </StaffjoyButton>,
              <StaffjoyButton
                buttonType="outline"
                size="tiny"
                key="yes-button"
                style={{ float: 'right' }}
                onClick={this.handleDeleteEmployeeClick}
              >
                {t('confirmed')}
              </StaffjoyButton>,
            ]}
          />
          <ConfirmationModal
            ref={(modal) => { this.errorModel = modal; }}
            title={t('warning')}
            content={t('msg.cannot_deleted_yourself')}
            buttons={[
              <StaffjoyButton
                buttonType="outline"
                size="tiny"
                key="yes-button"
                onClick={this.handleCancelModalClick}
              >
                {t('confirmed')}
              </StaffjoyButton>,
            ]}
          />
        </div>
        <div className="employees-sidebar">
          {children}
        </div>
      </div>
    );
  }
}

Employees.propTypes = {
  dispatch: PropTypes.func.isRequired,
  isFetching: PropTypes.bool.isRequired,
  companyUuid: PropTypes.string.isRequired,
  employees: PropTypes.array.isRequired,
  // filters: PropTypes.object.isRequired,
  updateSearchFilter: PropTypes.func.isRequired,
  teams: PropTypes.array.isRequired,
  children: PropTypes.element,
  tableRowClicked: PropTypes.func.isRequired,
  t: PropTypes.func.isRequired,
  deleteEmployee: PropTypes.func.isRequired,
  userUuid: PropTypes.string.isRequired,
};

function mapStateToProps(state, ownProps) {
  // apply filters to our list of employees
  const employees = [];
  const searchQuery = _.get(state.employees.filters, 'searchQuery', '');

  _.each(state.employees.data, (employee) => {
    if (employee.name.toLowerCase().includes(searchQuery) ||
      employee.email.includes(searchQuery)) {
      employees.push(employee);
    }
  });

  return {
    companyUuid: ownProps.routeParams.companyUuid,
    isFetching: !state.employees.lastUpdate || state.employees.isFetching,
    // filters: state.employees.filters,
    employees,
    teams: _.values(state.teams.data),
    userUuid: state.whoami.data.user_uuid,
  };
}

const mapDispatchToProps = (dispatch, ownProps) => ({
  tableRowClicked: (event, employeeUuid) => {
    hashHistory.push(
      getRoute(COMPANY_EMPLOYEE, {
        companyUuid: ownProps.routeParams.companyUuid,
        employeeUuid,
      })
    );
  },
  deleteEmployee: (companyUuid, userUuid) => {
    dispatch(actions.deleteEmployee(companyUuid, userUuid));
  },
  updateSearchFilter: (event) => {
    dispatch(actions.updateEmployeesSearchFilter(event.target.value));
  },
  dispatch,
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(translate('common')(Employees));
