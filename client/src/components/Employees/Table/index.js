import _ from 'lodash';
import React, { PropTypes } from 'react';
import TableHeader from './Header';
import TableRow from './Row';

require('./table.scss');

function Table({ columns, onRowClick, rows, uuidKeyName, handleShowModalClick }) {
  return (
    <table className="mdl-data-table mdl-js-data-table staffjoy-table">
      <TableHeader columns={columns} />
      <tbody>
        {
          _.map(rows, (row) => {
            const rowKey = `table-row-${row[uuidKeyName]}`;
            return (
              <TableRow
                key={rowKey}
                rowData={row}
                rowId={row[uuidKeyName]}
                columns={columns}
                onClick={onRowClick}
                handleShowModalClick={handleShowModalClick}
              />
            );
          })
        }
      </tbody>
    </table>
  );
}

Table.propTypes = {
  columns: PropTypes.arrayOf(PropTypes.object).isRequired,
  rows: PropTypes.arrayOf(PropTypes.object).isRequired,
  uuidKeyName: PropTypes.string.isRequired,
  onRowClick: PropTypes.func,
  handleShowModalClick: PropTypes.func.isRequired,
};

export default Table;
