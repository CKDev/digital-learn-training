import React from "react";
import { CssBaseline, ThemeProvider, createTheme } from "@mui/material";
import "@fontsource/nunito/300.css";
import "@fontsource/nunito/400.css";
import "@fontsource/nunito/500.css";
import "@fontsource/nunito/700.css";

const theme = createTheme({
  typography: {
    fontFamily: ["nunito", "Roboto", '"Open Sans"'].join(","),
  },
  components: {
    MuiTab: {
      styleOverrides: {
        root: {
          alignItems: "flex-start",
          textAlign: "left",
          boxShadow: "none", // Remove elevation shadows
          textTransform: "none",
          fontWeight: "regular",
          fontSize: "1rem",
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
      dark: "#006064",
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
