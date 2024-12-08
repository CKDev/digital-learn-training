import React from "react";
import { red } from "@mui/material/colors";
import { ThemeProvider, createTheme } from "@mui/material";

const theme = createTheme({
  components: {
    MuiTab: {
      styleOverrides: {
        root: {
          boxShadow: "none", // Remove elevation shadows
        },
      },
    },
  },
  // Get subsite theme from somewhere
  // palette: {
  //   primary: {
  //     main: red[500],
  //   },
  // },
});

const ThemedComponent = ({ children }) => (
  <React.StrictMode>
    <ThemeProvider theme={theme}>{children}</ThemeProvider>
  </React.StrictMode>
);

export default ThemedComponent;
