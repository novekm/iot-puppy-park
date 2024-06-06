/* eslint-disable no-console */
/* eslint-disable no-unused-vars */
/* eslint-disable react/prop-types */
import React, { useState } from 'react';
import { TopNavigation } from '@cloudscape-design/components';

// Amplify
import { signOut } from 'aws-amplify/auth';
// Company logo. Upload your own logo and point to it to change this in the TopNavigation.
import logo from '../../../public/images/AWS_logo_RGB_REV.png';

// Styles
import '../../styles/top-navigation.scss';

const TopNavigationHeader = ({userInfo, user }) => {
  // Function to sign user out
  // Function signOut renamed to appSignOut to prevent conflict with aws-amplify/auth - signOut
  async function appSignOut() {
    try {
      await signOut();
    } catch (error) {
      console.log('error signing out: ', error);
    }
  }
  return (
    <div id="h">
      <TopNavigation
        identity={{
          href: '/',
          // Your Company Name
          title: `Bittle Control`,
          logo: {
            src: logo,
            alt: 'Service',
          },
        }}
        utilities={[
          {
            type: 'button',
            text: 'AWS',
            href: 'https://aws.amazon.com/',
            external: true,
            externalIconAriaLabel: ' (opens in a new tab)',
          },
          {
            type: 'button',
            iconName: 'notification',
            title: 'Notifications',
            ariaLabel: 'Notifications (unread)',
            badge: true,
            disableUtilityCollapse: false,
          },
          {
            type: 'menu-dropdown',
            iconName: 'settings',
            ariaLabel: 'Settings',
            title: 'Settings',
            items: [
              {
                id: 'settings-org',
                text: 'Organizational settings',
              },
              {
                id: 'settings-project',
                text: 'Project settings',
              },
            ],
          },
          {
            type: 'menu-dropdown',
            text: `${userInfo.given_name} ${userInfo.family_name}`,
            description: `${userInfo.email}`,
            iconName: 'user-profile',
            items: [
              { id: 'profile', text: 'Profile' },
              // Use me once a user profile page is created
              // { id: "profile", text: "Profile", href : '/user-profile'},
              { id: 'preferences', text: 'Preferences' },
              { id: 'security', text: 'Security' },
              {
                id: 'support-group',
                text: 'Support',
                items: [
                  {
                    id: 'documentation',
                    text: 'Documentation',
                    // TODO - Replace this with link to our Workshop URL
                    href: 'https://workshops.aws/',
                    external: true,
                    externalIconAriaLabel: ' (opens in new tab)',
                  },
                  { id: 'support', text: 'Support' },
                  {
                    id: 'feedback',
                    text: 'Feedback',
                    // TODO - Replace this with link to our GitHub feedback mechanism
                    href: 'https://github.com/novekm/iot-puppy-park',
                    external: true,
                    externalIconAriaLabel: ' (opens in new tab)',
                  },
                ],
              },
              // eslint-disable-next-line jsx-a11y/click-events-have-key-events, jsx-a11y/no-static-element-interactions
              { id: 'signout', text: <span onClick={appSignOut}>Sign out </span> },
            ],
          },
        ]}
        i18nStrings={{
          // searchIconAriaLabel: "Search",
          // searchDismissIconAriaLabel: "Close search",
          overflowMenuTriggerText: 'More',
          // overflowMenuTitleText: "All",
          // overflowMenuBackIconAriaLabel: "Back",
          // overflowMenuDismissIconAriaLabel: "Close menu"
        }}
      />
    </div>
  );
};

export default TopNavigationHeader;