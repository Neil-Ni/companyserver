import _ from 'lodash';
import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { Field, reduxForm } from 'redux-form';
import { translate } from 'react-i18next';
import * as actions from 'actions';
import EmployeePanelPhotoName from './PhotoName';
import EmployeeFormField from './FormField';

require('./employee-side-panel.scss');

class EmployeeSidePanel extends React.Component {

  constructor(props) {
    super(props);
    this.handleFieldBlur = this.handleFieldBlur.bind(this);
  }

  componentDidMount() {
    const { dispatch, companyUuid, employeeUuid } = this.props;

    // get the employees for the whole company
    dispatch(actions.initializeEmployeeSidePanel(companyUuid, employeeUuid));
  }

  componentWillReceiveProps(nextProps) {
    const { dispatch, companyUuid, employeeUuid } = this.props;
    const newEmployeeUuid = nextProps.employeeUuid;

    // there are a lot of updates that will happen, but only need to fetch
    // if its because of a route change
    if (newEmployeeUuid !== employeeUuid) {
      dispatch(
        actions.initializeEmployeeSidePanel(companyUuid, newEmployeeUuid)
      );
    }
  }

  handleFieldBlur(event) {
    const { name } = event.target;
    const {
      companyUuid,
      dispatch,
      employeeUuid,
      updateEmployeeField,
    } = this.props;

    dispatch(updateEmployeeField(companyUuid, employeeUuid, name));
  }

  render() {
    const { employee, updatingFields, t } = this.props;

    return (
      <div className="employee-side-panel">
        <form>
          <EmployeePanelPhotoName
            name={employee.name}
            photoUrl={employee.photo_url}
          />
          <div className="info-section" id="contact-information">
            <h4 className="info-section-title">{t('contactInformation')}</h4>
            <div>
              <Field
                component={EmployeeFormField}
                iconKey="phone"
                name="phone_number"
                updateStatus={updatingFields && updatingFields.phonenumber}
                onBlur={this.handleFieldBlur}
              />
            </div>
            <div>
              <Field
                component={EmployeeFormField}
                iconKey="mail_outline"
                name="email"
                updateStatus={updatingFields && updatingFields.email}
                onBlur={this.handleFieldBlur}
              />
            </div>
          </div>
        </form>
      </div>
    );
  }
}

EmployeeSidePanel.propTypes = {
  dispatch: PropTypes.func.isRequired,
  companyUuid: PropTypes.string.isRequired,
  employeeUuid: PropTypes.string.isRequired,
  employee: PropTypes.object.isRequired,
  updateEmployeeField: PropTypes.func.isRequired,
  updatingFields: PropTypes.object.isRequired,
  t: PropTypes.func.isRequired,
};

function mapStateToProps(state, ownProps) {
  const employeeUuid = ownProps.routeParams.employeeUuid;
  const employee = _.get(state.employees.data, employeeUuid, {});
  const updatingFields = _.get(
    state.employees.updatingFields,
    employeeUuid,
    {}
  );
  const initialValues = employee;

  return {
    companyUuid: ownProps.routeParams.companyUuid,
    employee,
    employeeUuid,
    initialValues,
    updatingFields,
  };
}

const mapDispatchToProps = dispatch => ({
  updateEmployeeField: actions.updateEmployeeField,
  dispatch,
});

const Form = reduxForm({
  enableReinitialize: true,
  form: 'employee-side-panel',
})(translate('common')(EmployeeSidePanel));
const Container = connect(mapStateToProps, mapDispatchToProps)(Form);
export default Container;
