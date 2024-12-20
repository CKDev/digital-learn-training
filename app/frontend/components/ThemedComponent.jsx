import React from "react";
import { CssBaseline, ThemeProvider, createTheme } from "@mui/material";

const theme = createTheme({
  components: {
    MuiTab: {
      styleOverrides: {
        root: {
          alignItems: "flex-start",
          textAlign: "left",
          boxShadow: "none", // Remove elevation shadows
        },
      },
    },
  },
  // Get subsite theme from somewhere
  palette: {
    primary: {
      main: "#01579B",
      light: "#29B6F6",
    },
    info: {
      main: "#548687",
      dark: "#548687",
      contrastText: "#FFFFFF",
    },
    iconColor: "rgba(0, 0, 0, 0.56)",
  },
});

const ThemedComponent = ({ children }) => (
  <React.StrictMode>
    <CssBaseline />
    <ThemeProvider theme={theme}>{children}</ThemeProvider>
  </React.StrictMode>
);

export default ThemedComponent;
