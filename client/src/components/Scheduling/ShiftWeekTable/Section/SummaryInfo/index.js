import _ from 'lodash';
import moment from 'moment';
import 'moment-timezone';
import React, { PropTypes } from 'react';
import { translate } from 'react-i18next';
import { Icon } from 'react-mdl';
import ReactTooltip from 'react-tooltip';
import { getFormattedDuration } from '../../../../../utility';

require('./section-summary-info.scss');

class SectionSummaryInfo extends React.Component {
  getDuration = function getDuration(shifts, timezone) {
    const durationMs = _.reduce(shifts, (duration, shift) => {
      const momentStart = moment.utc(shift.start).tz(timezone);
      const momentStop = moment.utc(shift.stop).tz(timezone);
      const currentDuration = momentStop - momentStart;

      return duration + currentDuration;
    }, 0);

    return getFormattedDuration(durationMs);
  };

  getSummarizeInfo = function getSummarizeInfo({ hr, m }, t) {
    const format = [];

    if (hr > 0) {
      format.push(`${hr} ${t('hours')}`);
    }

    if (m > 0) {
      format.push(`${m} ${t('minutes')}`);
    }

    const formattedDuration = [t('total')].concat(format).join(' ');
    return (format.length > 0) ? formattedDuration : t('noTimeAssigned');
  };

  isOverScheduled = function isOverScheduled({ hr = 0 }) {
    return hr > 40;
  };

  render() {
    const { shifts, timezone, t, viewBy } = this.props;
    const formattedDurations = this.getDuration(shifts, timezone);
    const overScheduled = (viewBy === 'employee') ? this.isOverScheduled(formattedDurations) : false;

    return (
      <div className="section-summary-info">
        <span>{this.getSummarizeInfo(formattedDurations, t)}</span>
        {
          overScheduled ?
            <span
              className="error-button"
              data-tip={t('overScheduled')}
              data-type="error"
            >
              <Icon name="error_outline" />
              <ReactTooltip />
            </span> : ''
        }
      </div>
    );
  }
}

SectionSummaryInfo.propTypes = {
  shifts: PropTypes.array.isRequired,
  timezone: PropTypes.string.isRequired,
  t: PropTypes.func.isRequired,
  viewBy: PropTypes.string.isRequired,
};

export default translate('common')(SectionSummaryInfo);
