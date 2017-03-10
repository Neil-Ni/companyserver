import React, { PropTypes } from 'react';
import { translate } from 'react-i18next';

require('./info-side-panel.scss');

function InfoSidePanel({ t }) {
  return (
    <div className="employee-side-panel">
      <h3>{ t('infoPanel.title') }</h3>
      <p>{ t('infoPanel.msg') }</p>
    </div>
  );
}

InfoSidePanel.propTypes = {
  t: PropTypes.func.isRequired,
};

export default translate('common')(InfoSidePanel);
