import _ from 'lodash';
import moment from 'moment';
import React, { PropTypes } from 'react';
import { ScaleModal } from 'boron';
import { translate } from 'react-i18next';
import TimeSelector from 'components/TimeSelector';
import ShiftModalDaySelector from 'components/Scheduling/ShiftModalDaySelector';
import { ModalLayoutRightSideColumn } from 'components/ModalLayout';
import SelectableModalList from 'components/ModalLayout/SelectableList';
import StaffjoyButton from 'components/StaffjoyButton';
import { MOMENT_SHIFT_CARD_TIMES } from 'constants/config';
import { UNASSIGNED_SHIFTS } from 'constants/constants';
import PlusIcon from 'components/SVGs/PlusIcon';

class CreateShiftModal extends React.Component {

  constructor(props) {
    super(props);
    this.openModal = this.openModal.bind(this);
    this.saveButton = this.saveButton.bind(this);
    this.onModalClose = this.onModalClose.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.setInitialShiftData = this.setInitialShiftData.bind(this);
  }

  onModalClose() {
    this.props.modalCallbackToggle(false);
    this.props.clearSchedulingModalFormData();
  }

  setInitialShiftData() {
    const { containerComponent, updateSchedulingModalFormData,
      sectionUuid, viewBy } = this.props;

    switch (containerComponent) {
      case 'div':
        // if the user is on the "Job" tab and clicked on an empty
        // shift cell, we need to store the sectionUuid (ie. sectionUuid)
        // in redux form
        if (viewBy === 'job' && sectionUuid !== UNASSIGNED_SHIFTS) {
          updateSchedulingModalFormData({ selectedJob: sectionUuid });
        }
        break;
      case 'button':
        if (viewBy === 'job' && sectionUuid !== UNASSIGNED_SHIFTS) {
          updateSchedulingModalFormData({ selectedJob: sectionUuid });
        }
        break;
      default:
        break;
    }
  }

  openModal() {
    this.modal.show();
    this.setInitialShiftData();
    this.props.modalCallbackToggle(true);
  }

  closeModal() {
    this.modal.hide();
  }

  saveButton() {
    const { onSave, timezone } = this.props;
    this.closeModal();
    onSave(timezone);
  }

  render() {
    const { timezone, tableSize, startDate, containerComponent, employees,
      updateSchedulingModalFormData, containerProps, selectedDate, selectedRow,
      viewBy, modalFormData, sectionUuid, t } = this.props;
    let selectedUuid = (viewBy === 'employee') ? selectedRow : '';
    let launchContainer = null;
    const employeesArray = _.values(employees);

    // check whether valid data is supplied for whether save can be disabled
    const startMoment = moment(
      _.get(modalFormData, 'startFieldText', ''),
      MOMENT_SHIFT_CARD_TIMES
    );
    const stopMoment = moment(
      _.get(modalFormData, 'stopFieldText', ''),
      MOMENT_SHIFT_CARD_TIMES
    );

    const noEmployeesSelected = _.isEmpty(
      _.pickBy(modalFormData.selectedEmployees)
    );
    const noDaysSelected = _.isEmpty(_.pickBy(modalFormData.selectedDays));

    const disabledSave = !startMoment.isValid() ||
                         !stopMoment.isValid() ||
                         startMoment.isSameOrAfter(stopMoment) ||
                         noEmployeesSelected ||
                         noDaysSelected;

    if (viewBy === 'job') {
      employeesArray.unshift({
        user_uuid: '',
        name: t('unassigned'),
      });
    }

    if (selectedUuid === UNASSIGNED_SHIFTS) {
      selectedUuid = '';
    }

    // define the component that must be clicked in order to open the modal
    switch (containerComponent) {
      case 'div':
        launchContainer = (
          <div
            {...containerProps}
            onClick={this.openModal}
          />
        );
        break;

      case 'button':
        launchContainer = (
          <StaffjoyButton
            {...containerProps}
            onClick={this.openModal}
          >
            <PlusIcon
              fill="#9a9699"
              width="20px"
              height="20px"
            />
          </StaffjoyButton>
        );
        break;

      default:
        launchContainer = (
          <div
            {...containerProps}
            onClick={this.openModal}
          />
        );
        break;
    }

    const selectableList = (
      <SelectableModalList
        records={employeesArray}
        displayByProperty="name"
        selectedUuid={selectedUuid}
        formField="selectedEmployees"
        formCallback={updateSchedulingModalFormData}
        uuidKey="user_uuid"
        sectionUuid={sectionUuid}
      />
    );

    return (
      <div>
        <ScaleModal
          ref={(modal) => { this.modal = modal; }}
          contentStyle={{
            /* due to chrome css bug */
            animation: 'none',
            borderRadius: '3px',
          }}
          modalStyle={{ width: '640px' }}
          onHide={this.onModalClose}
        >
          <ModalLayoutRightSideColumn
            title={t('createNewShift')}
            panelTitle={t('selectEmployees')}
            panelContent={selectableList}
            buttons={[
              <StaffjoyButton
                buttonType="outline"
                size="small"
                key="cancel-button"
                onClick={this.closeModal}
              >
                {t('cancel')}
              </StaffjoyButton>,
              <StaffjoyButton
                buttonType="primary"
                size="small"
                key="create-button"
                onClick={this.saveButton}
                disabled={disabledSave}
              >
                {t('save')}
              </StaffjoyButton>,
            ]}
          >
            <TimeSelector
              timezone={timezone}
              formCallback={updateSchedulingModalFormData}
            />
            <ShiftModalDaySelector
              tableSize={tableSize}
              startDate={startDate}
              selectedDate={selectedDate}
              formCallback={updateSchedulingModalFormData}
            />
          </ModalLayoutRightSideColumn>
        </ScaleModal>
        {launchContainer}
      </div>
    );
  }
}

CreateShiftModal.propTypes = {
  tableSize: PropTypes.number.isRequired,
  startDate: PropTypes.string.isRequired,
  timezone: PropTypes.string.isRequired,
  onSave: PropTypes.func.isRequired,
  modalCallbackToggle: PropTypes.func.isRequired,
  containerComponent: PropTypes.string.isRequired,
  containerProps: PropTypes.object.isRequired,
  selectedDate: PropTypes.string,
  viewBy: PropTypes.string.isRequired,
  selectedRow: PropTypes.string,
  employees: PropTypes.object.isRequired,
  modalFormData: PropTypes.object.isRequired,
  updateSchedulingModalFormData: PropTypes.func.isRequired,
  clearSchedulingModalFormData: PropTypes.func.isRequired,
  sectionUuid: PropTypes.string,
  t: PropTypes.func.isRequired,
};

export default translate('common')(CreateShiftModal);
