/* eslint-disable no-sequences */
/* eslint-disable jsx-a11y/anchor-is-valid */
/* eslint-disable react/prop-types */
import React from 'react';
import {
  CollectionPreferences,
  // StatusIndicator,
  Link,
} from '@cloudscape-design/components';
import { addColumnSortLabels } from '../labels';

export const COLUMN_DEFINITIONS = addColumnSortLabels([
  {
    id: 'DeviceName',
    cell: (item) => (
      <Link href={`/my-bittles/${item.DeviceId}`}>{item.DeviceName}</Link>
    ),
    header: 'Device Name',
    minWidth: 120,
    maxWidth: 200,
    sortingField: 'DeviceName',
  },
  {
    id: 'DeviceId',
    header: 'Device Id',
    cell: (item) => item.DeviceId,
    minWidth: 200,
    sortingField: 'DeviceId',
  },
  {
    id: 'DeviceStatus',
    header: 'Device Status',
    cell: (item) => item.DeviceStatus,
    minWidth: 160,
    maxWidth: 200,
    sortingField: 'DeviceStatus',
  },
  {
    id: 'Battery',
    header: 'Battery',
    cell: (item) => item.Battery,
    minWidth: 100,
    maxWidth: 100,
    sortingField: 'Battery',
  },

  {
    id: 'ShortName',
    header: 'Short Name',
    cell: (item) => item.ShortName,
    minWidth: 100,
    sortingField: 'ShortName',
  },
  {
    id: 'NyboardVersion',
    header: 'Nyboard Version',
    cell: (item) => item.NyboardVersion,
    minWidth: 100,
    sortingField: 'NyboardVersion',
  },

  // This eventually could be used for error handling
  // Could maybe have State of 'Verified', 'Unverified', 'Failed', etc. to give more info
  // {
  //   id: 'JobStatus',
  //   header: 'Job Status',
  //   //  cell: item => item.JobStatus,
  //   cell: (item) => (
  //     item.JobStatus,
  //     (
  //       <StatusIndicator type={item.state === 'Disabled' ? 'error' : 'success'}>
  //         {' '}
  //         {item.state}
  //         {item.JobStatus}
  //       </StatusIndicator>
  //     )
  //   ),
  //   minWidth: 100,
  //   sortingField: 'JobStatus',
  // },
]);

export const PAGE_SIZE_OPTIONS = [
  { value: 10, label: '10 Bittles' },
  { value: 30, label: '30 Bittles' },
  { value: 50, label: '50 Bittles' },
];

export const FILTERING_PROPERTIES = [
  {
    propertyLabel: 'Device Name',
    key: 'DeviceName',
    groupValuesLabel: 'Device Name values',
    operators: [':', '!:', '=', '!='],
  },
  {
    propertyLabel: 'Device Id',
    key: 'DeviceId',
    groupValuesLabel: 'DeviceId values',
    operators: [':', '!:', '=', '!='],
  },
  {
    propertyLabel: 'Device Status',
    key: 'DeviceStatus',
    groupValuesLabel: 'Device Status values',
    operators: [':', '!:', '=', '!='],
  },
  {
    propertyLabel: 'Battery',
    key: 'Battery',
    groupValuesLabel: 'Battery values',
    operators: [':', '!:', '=', '!='],
  },
  {
    propertyLabel: 'Short Name',
    key: 'ShortName',
    groupValuesLabel: 'Short Name values',
    operators: [':', '!:', '=', '!='],
  },
  {
    propertyLabel: 'Nyboard Version',
    key: 'NyboardVersion',
    groupValuesLabel: 'Nyboard Version values',
    operators: [':', '!:', '=', '!='],
  },
];

export const PROPERTY_FILTERING_I18N_CONSTANTS = {
  filteringAriaLabel: 'your choice',
  dismissAriaLabel: 'Dismiss',

  filteringPlaceholder: 'Search',
  groupValuesText: 'Values',
  groupPropertiesText: 'Properties',
  operatorsText: 'Operators',

  operationAndText: 'and',
  operationOrText: 'or',

  operatorLessText: 'Less than',
  operatorLessOrEqualText: 'Less than or equal',
  operatorGreaterText: 'Greater than',
  operatorGreaterOrEqualText: 'Greater than or equal',
  operatorContainsText: 'Contains',
  operatorDoesNotContainText: 'Does not contain',
  operatorEqualsText: 'Equals',
  operatorDoesNotEqualText: 'Does not equal',

  editTokenHeader: 'Edit filter',
  propertyText: 'Property',
  operatorText: 'Operator',
  valueText: 'Value',
  cancelActionText: 'Cancel',
  applyActionText: 'Apply',
  allPropertiesLabel: 'All properties',

  tokenLimitShowMore: 'Show more',
  tokenLimitShowFewer: 'Show fewer',
  clearFiltersText: 'Clear filters',
  removeTokenButtonAriaLabel: () => 'Remove token',
  enteredTextLabel: (text) => `Use: "${text}"`,
};
export const CUSTOM_PREFERENCE_OPTIONS = [
  { value: 'table', label: 'Table' },
  { value: 'cards', label: 'Cards' },
];
export const DEFAULT_PREFERENCES = {
  pageSize: 30,
  visibleContent: [
    'DeviceName',
    'DeviceId',
    'DeviceStatus',
    'Battery',
    'ShortName',
    'NyboardVersion',
  ],
  wraplines: false,
  custom: CUSTOM_PREFERENCE_OPTIONS[0].value,
};

export const VISIBLE_CONTENT_OPTIONS = [
  {
    label: 'Main My Bittles Table properties',
    options: [
      { id: 'DeviceName', label: 'Device Name', editable: false },
      { id: 'DeviceId', label: 'Device ID', editable: true },
      { id: 'DeviceStatus', label: 'Device Status', editable: true },
      { id: 'Battery', label: 'Battery', editable: true },
      { id: 'ShortName', label: 'Short Name', editable: true },
      { id: 'NyboardVersion', label: 'NyboardVersion', editable: true },

      // { id: 'CreatedAt', label: 'Created At', editable: true },
    ],
  },
];
export const Preferences = ({
  preferences,
  setPreferences,
  disabled,
  pageSizeOptions = PAGE_SIZE_OPTIONS,
  visibleContentOptions = VISIBLE_CONTENT_OPTIONS,
}) => (
  <CollectionPreferences
    title="Preferences"
    confirmLabel="Confirm"
    cancelLabel="Cancel"
    disabled={disabled}
    preferences={preferences}
    onConfirm={({ detail }) => setPreferences(detail)}
    pageSizePreference={{
      title: 'Page size',
      options: pageSizeOptions,
    }}
    wrapLinesPreference={{
      label: 'Wrap lines',
      description: 'Check to see all the text and wrap the lines',
    }}
    visibleContentPreference={{
      title: 'Select visible columns',
      options: visibleContentOptions,
    }}
  />
);
