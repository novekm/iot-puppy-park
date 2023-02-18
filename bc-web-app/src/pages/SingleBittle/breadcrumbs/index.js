/* eslint-disable no-unused-vars */
/* eslint-disable import/no-extraneous-dependencies */
import { useParams } from 'react-router';
// let { activityEventId } = useParams();
export const resourcesBreadcrumbs = [
  {
    text: ' Bittle Control',
    href: '/dashboard',
  },
  {
    text: 'My Bittles',
    href: '/my-bittles',
  },
  {
    text: 'Single Bittle',
    href: '#',
  },
  // TODO - Make this dynamic with useParams
  // {
  //   text: 'carbon-lake-AGKI571',
  //   href: '#',
  // },
  // {
  //   text: `${activityEventId}`,
  //   href: '#',
  // },
];

// export const resourceDetailBreadcrumbs = [
//   ...resourcesBreadcrumbs,
//   {
//     text: 'SampleRecord1234',
//     href: '#',
//   },
// ];

// export const resourceManageTagsBreadcrumbs = [
//   ...resourceDetailBreadcrumbs,
//   {
//     text: 'Manage tags',
//     href: '#',
//   },
// ];

// export const resourceEditBreadcrumbs = [
//   ...resourceDetailBreadcrumbs,
//   {
//     text: 'Edit',
//     href: '#',
//   },
// ];

// export const resourceCreateBreadcrumbs = [
//   ...resourcesBreadcrumbs,
//   {
//     text: 'Upload Emissions',
//     href: '#',
//   },
// ];

// export const readFromS3Breadcrumbs = [
//   ...resourceDetailBreadcrumbs,
//   {
//     text: 'Run simulation',
//     href: '#',
//   },
// ];

// export const writeToS3Breadcrumbs = [
//   ...resourceDetailBreadcrumbs,
//   {
//     text: 'Create simulation',
//     href: '#',
//   },
// ];
