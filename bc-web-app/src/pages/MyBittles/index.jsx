/* eslint-disable react/no-unescaped-entities */
/* eslint-disable react/jsx-props-no-spreading */
/* eslint-disable react/prop-types */
/* eslint-disable import/no-cycle */
/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
/** **********************************************************************
                            DISCLAIMER

This is just a playground package. It does not comply with best practices
of using Cloudscape Design components. For production code, follow the
integration guidelines:

https://cloudscape.design/patterns/patterns/overview/
*********************************************************************** */
import React, { useState, useEffect } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
// COMPONENT IMPORTS
import {
  Alert,
  Badge,
  BreadcrumbGroup,
  Button,
  Flashbar,
  AppLayout,
  SideNavigation,
  Container,
  Header,
  HelpPanel,
  Grid,
  Box,
  Icon,
  TextContent,
  SpaceBetween,
} from '@cloudscape-design/components';
import TopNavigationHeader from '../../common/components/TopNavigationHeader';
// Common
import { useColumnWidths } from '../../common/resources/useColumnWidths';
import {
  Notifications,
  ExternalLinkItem,
  TableHeader,
} from '../../common/common-components-config';
import Sidebar from '../../common/components/Sidebar';

import { COLUMN_DEFINITIONS } from './MyBittlesTable/table-property-filter-config';

import MyBittlesTable from './MyBittlesTable';
import { resourcesBreadcrumbs } from './breadcrumbs';

// Styles
import '../../common/styles/base.scss';

const MyBittles = () => {
  const [columnDefinitions, saveWidths] = useColumnWidths(
    'React-TableServerSide-Widths',
    COLUMN_DEFINITIONS
  );
  const [toolsOpen, setToolsOpen] = useState(false);
  return (
    <AppLayout
      navigation={<Sidebar activeHref="/my-bittles" />}
      // notifications={<Notifications successNotification={false} />}
      breadcrumbs={<Breadcrumbs />} // define these values in /breadcrumbs/index.js
      content={
        <MyBittlesTable
          columnDefinitions={columnDefinitions} // define these values in /TCAJobsTable/table-property-filter-config.jsx
          saveWidths={saveWidths}
          updateTools={() => setToolsOpen(true)}
        />
      }
      contentType="table"
      tools={<ToolsContent />}
      toolsOpen={toolsOpen}
      onToolsChange={({ detail }) => setToolsOpen(detail.open)}
      stickyNotifications
    />
  );
};

export default MyBittles;

const Content = () => {
  const [columnDefinitions, saveWidths] = useColumnWidths(
    'React-TableServerSide-Widths',
    COLUMN_DEFINITIONS
  );
  const { userId } = useParams();
  return (
    <MyBittlesTable
      columnDefinitions={columnDefinitions} // define these values in /TCAJobsTable/table-property-filter-config.jsx
      saveWidths={saveWidths}
      updateTools={() => setToolsOpen(true)}
    />
  );
};

export const Breadcrumbs = () => (
  <BreadcrumbGroup
    items={resourcesBreadcrumbs}
    expandAriaLabel="Show path"
    ariaLabel="Breadcrumbs"
  />
);

export const FullPageHeader = ({
  resourceName = 'Bittles',
  createButtonText = 'Add Bittle',
  ...props
}) => {
  const navigate = useNavigate();
  const isOnlyOneSelected = props.selectedItems.length === 1;

  return (
    <TableHeader
      variant="awsui-h1-sticky"
      title={resourceName}
      actionButtons={
        <SpaceBetween size="xs" direction="horizontal">
          <Button disabled={!isOnlyOneSelected}>View details</Button>
          <Button disabled={!isOnlyOneSelected}>Edit</Button>
          <Button disabled={props.selectedItems.length === 0}>Delete</Button>
          {/* <Button onClick={() => navigate("/data-uploader")} variant="primary">{createButtonText}</Button> */}
          <Button onClick={() => navigate('/data-uploader')} variant="primary">
            {createButtonText}
          </Button>
        </SpaceBetween>
      }
      {...props}
    />
  );
};

export const ToolsContent = () => (
  <HelpPanel
    header={<h2>My Bittles</h2>}
    footer={
      <>
        <h3>
          Learn more{' '}
          <span role="img" aria-label="Icon external Link">
            <Icon name="external" />
          </span>
        </h3>
        <ul>
          <li>
            <ExternalLinkItem
              href="https://aws.amazon.com/energy/"
              text="AWS Energy & Utilities"
            />
          </li>
          {/* <li>
            <ExternalLinkItem
              href="https://aws.amazon.com/energy/"
              text="TBD - Amazon TCAQS Blog Post"
            />
          </li> */}
          <li>
            <ExternalLinkItem
              href="https://aws.amazon.com/s3/"
              text="Amazon S3"
            />
          </li>
        </ul>
      </>
    }
  >
    <p>
      View your current current Bittes and relevant device information. To drill
      down even further into the details and issue commands, select the name of
      an individual Bittle.
    </p>
  </HelpPanel>
);

export const MyBittlesTableEmptyState = ({ resourceName }) => {
  const navigate = useNavigate();

  return (
    <Box margin={{ vertical: 'xs' }} textAlign="center" color="inherit">
      <SpaceBetween size="xxs">
        <div>
          <b>No {resourceName}</b>
          <Box variant="p" color="inherit">
            No {resourceName}s found. Click 'Create {resourceName}' to add a
            Bittle.
          </Box>
        </div>
        <Button onClick={() => navigate('/data-uploader')}>
          Create {resourceName}
        </Button>
      </SpaceBetween>
    </Box>
  );
};
