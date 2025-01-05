import { Tab, Tabs } from "@mui/material";
import React from "react";

const AdminSidebar = ({ currentPath, accessRequestsEnabled }) => {
  const adminHttpRoutes = [
    {
      title: "Courses",
      path: "/admin/courses",
    },
    {
      title: "Course Categories",
      path: "/admin/categories",
    },
    {
      title: "Instructional Design Trainings",
      path: "/admin/trainings",
    },
    {
      title: '"Learn More" Pages',
      path: "/admin/pages",
      withDivider: true,
    },
    {
      title: "Change Login Information",
      path: "/users/edit",
    },
  ];

  if (accessRequestsEnabled) {
    // Only add this option if access requests are enabled
    adminHttpRoutes.push({
      title: "Invite Collaborator",
      path: "/users/invitation/new",
    });
  }

  const handleNavigation = (_event, path) => (window.location.href = path);
  const handleClick = (event) => {
    console.log(event.target);
  };

  function a11yProps(path) {
    return {
      id: `admin-nav-tab-${path}`,
      "aria-controls": `admin-path-${path}`,
    };
  }

  if (currentPath == "/admin") {
    // Handle root path name
    currentPath = "/admin/courses";
  }

  if (currentPath.match(/\/courses\//g)) {
    currentPath = "/admin/courses";
  }

  return (
    <Tabs
      orientation="vertical"
      variant="scrollable"
      value={currentPath}
      onChange={handleNavigation}
      onClick={handleClick}
      aria-label="User Navigation Menu"
      sx={{ borderRight: 1, borderColor: "divider" }}
    >
      {adminHttpRoutes.map((route) => (
        <Tab
          label={route.title}
          value={route.path}
          {...a11yProps(route.path)}
          key={"admin-nav-tab-" + route.path}
          sx={
            route.withDivider == true
              ? {
                  borderBottom: 1,
                  borderColor: "divider",
                }
              : {}
          }
        />
      ))}
    </Tabs>
  );
};

export default AdminSidebar;
