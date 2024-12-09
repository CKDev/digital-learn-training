import { Tab, Tabs } from "@mui/material";
import React from "react";

const UserSidebar = ({ currentPath }) => {
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
      title: "Additional Resources",
      path: "/additional-resources",
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

  return (
    <Tabs
      orientation="vertical"
      variant="scrollable"
      value={currentPath}
      onChange={handleNavigation}
      aria-label="User Navigation Menu"
      sx={{ borderRight: 1, borderColor: "divider" }}
    >
      {userHttpRoutes.map((route) => (
        <Tab
          label={route.title}
          value={route.path}
          {...a11yProps(route.path)}
          key={"user-nav-tab-" + route.path}
        />
      ))}
    </Tabs>
  );
};

export default UserSidebar;
