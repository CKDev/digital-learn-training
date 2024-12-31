import React from "react";
import { useMediaQuery, useTheme } from "@mui/material";
import SidebarDrawer from "./user_sidebar/SidebarDrawer";
import SidebarTabs from "./user_sidebar/SidebarTabs";

const UserSidebar = ({ currentPath }) => {
  const theme = useTheme();
  const isSmallScreen = useMediaQuery(theme.breakpoints.down("md"));

  const checklistDownloadPath = "tech-skills-checklist-survey-only.pdf";

  const userHttpRoutes = [
    {
      title: "Course Materials",
      path: "/courses",
    },
    {
      title: "Instructional Design Training",
      path: "/trainings",
    },
    {
      title: "Templates to Make Your Own Materials",
      path: "/templates",
    },
    {
      title: "Contribute to DigitalLearn",
      path: "/contribute",
    },
  ];

  const handleNavigation = (_event, path) => (window.location.href = path);

  function a11yProps(path) {
    return {
      id: `user-nav-tab-${path}`,
      "aria-controls": `user-path-${path}`,
    };
  }

  if (isSmallScreen) {
    return (
      <SidebarDrawer
        a11yProps={a11yProps}
        currentPath={currentPath}
        handleNavigation={handleNavigation}
        checklistDownloadPath={checklistDownloadPath}
        userHttpRoutes={userHttpRoutes}
      />
    );
  } else {
    return (
      <SidebarTabs
        a11yProps={a11yProps}
        currentPath={currentPath}
        handleNavigation={handleNavigation}
        checklistDownloadPath={checklistDownloadPath}
        userHttpRoutes={userHttpRoutes}
      />
    );
  }
};

export default UserSidebar;
