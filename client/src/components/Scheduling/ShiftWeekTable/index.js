import _ from 'lodash';
import moment from 'moment';
import React, { PropTypes } from 'react';
import { translate } from 'react-i18next';
import {
  MOMENT_DATE_DISPLAY,
  MOMENT_ISO_DATE,
} from 'constants/config';
import LoadingScreen from 'components/LoadingScreen';
import ShiftWeekTableHeader from './Header';
import ShiftWeekTableSection from './Section';

require('./shift-week-table.scss');


class ShiftWeekTable extends React.Component {

  organizeShiftsIntoSections() {
    const { viewBy } = this.props;

    if (viewBy === 'employee') {
      return this.shiftsByEmployee();
    } else if (viewBy === 'job') {
      return this.shiftsByJob();
    }

    return [];
  }

  shiftsByEmployee() {
    const { employees, shifts, filters } = this.props;
    const searchQuery = _.get(filters, 'searchQuery', '');
    const response = {};

    _.forEach(employees, (employee, uuid) => {
      if (employee.name.toLowerCase().includes(searchQuery) ||
          employee.email.includes(searchQuery)
      ) {
        response[uuid] = _.extend({}, employee, {
          uuid,
          shifts: [],
        });
      }
    });

    _.forEach(shifts, (shift) => {
      // unassigned shifts will be ignored here
      if (_.has(response, shift.user_uuid)) {
        response[shift.user_uuid].shifts.push(shift);
      }
    });

    return _.sortBy(_.values(response), 'name');
  }

  shiftsByJob() {
    const { jobs, shifts, filters } = this.props;
    const activeJobs = _.pickBy(jobs, job => !job.archived);
    const searchQuery = _.get(filters, 'searchQuery', '');
    const response = {};

    _.forEach(activeJobs, (job, uuid) => {
      if (job.name.toLowerCase().includes(searchQuery)) {
        response[uuid] = _.extend({}, job, { shifts: [] });
      }
    });

    _.forEach(shifts, (shift) => {
      // unassigned shifts will be included here
      if (_.has(response, shift.job_uuid)) {
        response[shift.job_uuid].shifts.push(shift);
      }
    });

    return _.sortBy(_.values(response), 'name');
  }

  buildColumns() {
    const { startDate, tableSize, t } = this.props;
    const startMoment = moment(startDate);

    return _.map(_.range(tableSize), (i) => {
      const calDate = startMoment.clone().add(i, 'days');
      const day = calDate.format('ddd');
      const dateLabel = t(`dayShortNameMap.${day.toLowerCase()}`);
      return {
        columnId: calDate.format(MOMENT_ISO_DATE),
        columnHeader: `${dateLabel} ${calDate.format(MOMENT_DATE_DISPLAY)}`,
      };
    });
  }

  render() {
    const { employees, jobs, tableSize, viewBy, timezone, modalOpen,
      droppedSchedulingCard, toggleSchedulingModal, editTeamShift,
      deleteTeamShift, startDate, updateSchedulingModalFormData,
      clearSchedulingModalFormData, createTeamShift, modalFormData,
      isSaving, companyUuid, teamUuid } = this.props;

    const columns = this.buildColumns();

    return (
      <div className="shift-week-table">
        {isSaving &&
          <LoadingScreen
            containerProps={{
              style: {
                position: 'absolute',
                top: '0',
                bottom: '0',
                right: '0',
                left: '0',
                zIndex: '99',
                backgroundColor: 'rgba(255, 255, 255, 0.75)',
                marginTop: '0',
                paddingTop: '115px',
                opacity: '1',
              },
            }}
          />}
        <div className="scrolling-panel">
          <ShiftWeekTableHeader
            columns={columns}
            tableSize={tableSize}
          />
          {
            // TODO add unassigned shifts row if it's viewType employees
            _.map(this.organizeShiftsIntoSections(), (group) => {
              const sectionKey = `shift-table-section-${group.uuid}`;
              return (
                <ShiftWeekTableSection
                  columns={columns}
                  tableSize={tableSize}
                  shifts={group.shifts}
                  name={group.name}
                  sectionType={viewBy}
                  sectionUuid={group.uuid}
                  timezone={timezone}
                  viewBy={viewBy}
                  photoUrl={_.get(group, 'photo_url', '')}
                  employees={employees}
                  jobs={jobs}
                  droppedSchedulingCard={droppedSchedulingCard}
                  key={sectionKey}
                  deleteTeamShift={deleteTeamShift}
                  toggleSchedulingModal={toggleSchedulingModal}
                  modalOpen={modalOpen}
                  modalFormData={modalFormData}
                  createTeamShift={createTeamShift}
                  editTeamShift={editTeamShift}
                  startDate={startDate}
                  updateSchedulingModalFormData={updateSchedulingModalFormData}
                  clearSchedulingModalFormData={clearSchedulingModalFormData}
                  onCardZAxisChange={this.props.onCardZAxisChange}
                  companyUuid={companyUuid}
                  teamUuid={teamUuid}
                />
              );
            })
          }
        </div>
      </div>
    );
  }
}

ShiftWeekTable.propTypes = {
  tableSize: PropTypes.number.isRequired,
  startDate: PropTypes.string.isRequired,
  employees: PropTypes.object.isRequired,
  jobs: PropTypes.object.isRequired,
  viewBy: PropTypes.string.isRequired,
  shifts: PropTypes.arrayOf(PropTypes.object).isRequired,
  filters: PropTypes.object.isRequired,
  timezone: PropTypes.string.isRequired,
  droppedSchedulingCard: PropTypes.func.isRequired,
  deleteTeamShift: PropTypes.func.isRequired,
  toggleSchedulingModal: PropTypes.func.isRequired,
  editTeamShift: PropTypes.func.isRequired,
  createTeamShift: PropTypes.func.isRequired,
  modalOpen: PropTypes.bool.isRequired,
  modalFormData: PropTypes.object.isRequired,
  updateSchedulingModalFormData: PropTypes.func.isRequired,
  clearSchedulingModalFormData: PropTypes.func.isRequired,
  onCardZAxisChange: PropTypes.func.isRequired,
  isSaving: PropTypes.bool.isRequired,
  companyUuid: PropTypes.string.isRequired,
  teamUuid: PropTypes.string.isRequired,
  t: PropTypes.func.isRequired,
};

export default translate('common')(ShiftWeekTable);
