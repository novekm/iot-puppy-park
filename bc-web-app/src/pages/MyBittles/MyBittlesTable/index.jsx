/* eslint-disable react/jsx-props-no-spreading */
/* eslint-disable no-console */
/* eslint-disable no-use-before-define */
/* eslint-disable react/prop-types */
/* eslint-disable import/no-cycle */
/* eslint-disable no-unused-vars */
/** **********************************************************************
                            DISCLAIMER

This is just a playground package. It does not comply with best practices
of using Cloudscape Design components. For production code, follow the
integration guidelines:

https://cloudscape.design/patterns/patterns/overview/
*********************************************************************** */

import React, { useState, useEffect } from 'react';
import { useCollection } from '@cloudscape-design/collection-hooks';
import {
  PropertyFilter,
  Pagination,
  Table,
} from '@cloudscape-design/components';

import { generateClient } from 'aws-amplify/api';
import {
  getAllBittles,
  getAllBittlesPaginated,
  getOneBittle,
} from '../../../graphql/queries';
import { deleteOneBittle } from '../../../graphql/mutations';

import { getFilterCounterText } from '../../../common/resources/tableCounterStrings';
import { FullPageHeader, MyBittlesTableEmptyState } from '../index';
import {
  CustomAppLayout,
  Navigation,
  TableNoMatchState,
  Notifications,
} from '../../../common/common-components-config';
import { paginationLabels, transcriptSelectionLabels } from '../labels';
import {
  FILTERING_PROPERTIES,
  PROPERTY_FILTERING_I18N_CONSTANTS,
  DEFAULT_PREFERENCES,
  Preferences,
} from './table-property-filter-config';

import '../../../common/styles/base.scss';
import { useLocalStorage } from '../../../common/resources/localStorage';

import { useTCAJobs, useTCAJobsPropertyFiltering } from './hooks';

const client = generateClient();

const BittlesTable = ({ updateTools, saveWidths, columnDefinitions }) => {
  // Below are variables declared to maintain the table's state.
  // Each declaration returns two values: the first value is the current state, and the second value is the function that updates it.
  // They use the general format: [x, setX] = useState(defaultX), where x is the attribute you want to keep track of.
  // For more info about state variables and hooks, see https://reactjs.org/docs/hooks-state.html.

  const [Bittles, setBittles] = useState([]);
  // const [selectedTranscripts, setSelectedTranscripts] = useState([]);

  const [distributions, setDistributions] = useState([]);
  const [preferences, setPreferences] = useLocalStorage(
    'React-Bittles-Table-Preferences',
    DEFAULT_PREFERENCES
  );
  // const [preferences, setPreferences] = useState(DEFAULT_PREFERENCES);
  const [loading, setLoading] = useState(true);

  // a utility to handle operations on the data set (such as filtering, sorting and pagination)
  const {
    items,
    actions,
    filteredItemsCount,
    collectionProps,
    paginationProps,
    propertyFilterProps,
  } = useCollection(Bittles, {
    propertyFiltering: {
      filteringProperties: FILTERING_PROPERTIES,
      empty: <MyBittlesTableEmptyState resourceName="Bittle" />,
      noMatch: (
        <TableNoMatchState
          onClearFilter={() => {
            actions.setPropertyFiltering({ tokens: [], operation: 'and' });
          }}
        />
      ),
    },
    pagination: { pageSize: preferences.pageSize },
    sorting: { defaultState: { sortingColumn: columnDefinitions[0] } },
    selection: {},
  });

  useEffect(() => {
    fetchBittles();
  }, []);

  const fetchBittles = async () => {
    try {
      const BittleData = await client.graphql({ query: getAllBittles,variables: { limit: 10000 }});
      const BittleDataList = BittleData.data.getAllBittles.items;
      console.log('Bittles List', BittleDataList);
      setBittles(BittleDataList);
      setLoading(false);
    } catch (error) {
      console.log('error on fetching Bittles', error);
    }
  };

  return (
    <Table
      {...collectionProps}
      items={items}
      columnDefinitions={columnDefinitions}
      visibleColumns={preferences.visibleContent}
      ariaLabels={transcriptSelectionLabels}
      selectionType="multi"
      variant="full-page"
      stickyHeader
      resizableColumns
      wrapLines={preferences.wrapLines}
      onColumnWidthsChange={saveWidths}
      header={
        <FullPageHeader
          selectedItems={collectionProps.selectedItems}
          totalItems={Bittles}
          updateTools={updateTools}
          serverSide={false}
        />
      }
      loading={loading}
      loadingText="Loading Bittles..."
      filter={
        <PropertyFilter
          i18nStrings={PROPERTY_FILTERING_I18N_CONSTANTS}
          {...propertyFilterProps}
          countText={getFilterCounterText(filteredItemsCount)}
          expandToViewport
        />
      }
      pagination={
        <Pagination {...paginationProps} ariaLabels={paginationLabels} />
      }
      preferences={
        <Preferences
          preferences={preferences}
          setPreferences={setPreferences}
        />
      }
    />
  );
};

export default BittlesTable;