import React, { Suspense } from "react";
import {
  CircularProgress,
  CssBaseline,
  ThemeProvider,
  alpha,
  createTheme,
} from "@mui/material";
import "@fontsource/nunito/300.css";
import "@fontsource/nunito/400.css";
import "@fontsource/nunito/500.css";
import "@fontsource/nunito/700.css";

const defaultThemeData = {
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
};

// Org-level button customizations. Color only applies to primary contained
// (filled) and outlined buttons, so links, icons, and text buttons keep using
// the primary palette color.
const buttonOverrides = (theme, { color, shape } = {}) => {
  const buttonColor = color
    ? theme.palette.augmentColor({ color: { main: color, contrastText: "#FFFFFF" } })
    : null;

  return {
    components: {
      MuiButton: {
        styleOverrides: {
          root: ({ ownerState }) => {
            const styles = {};
            if (shape === "rounded") {
              // Nunito's line box reserves more space below the baseline than
              // its caps use, so uppercase labels sit slightly high. That's
              // noticeable against symmetric pill ends, so shift the label
              // down 1px while keeping MUI's total vertical padding per size.
              const basePadding = { small: 4, medium: 6, large: 8 }[ownerState.size] ?? 6;
              const padding = ownerState.variant === "outlined" ? basePadding - 1 : basePadding;
              Object.assign(styles, {
                borderRadius: 9999,
                paddingTop: padding + 1,
                paddingBottom: padding - 1,
              });
            }
            if (buttonColor && ownerState.color === "primary") {
              if (ownerState.variant === "contained") {
                Object.assign(styles, {
                  backgroundColor: buttonColor.main,
                  color: buttonColor.contrastText,
                  "&:hover": { backgroundColor: buttonColor.dark },
                });
              } else if (ownerState.variant === "outlined") {
                Object.assign(styles, {
                  color: buttonColor.main,
                  borderColor: buttonColor.main,
                  "&:hover": {
                    borderColor: buttonColor.dark,
                    backgroundColor: alpha(buttonColor.main, theme.palette.action.hoverOpacity),
                  },
                });
              }
            }
            return styles;
          },
        },
      },
    },
  };
};

const ThemedComponent = ({ children }) => {
  const { buttons, ...overrides } = window.orgThemeOverrides || {};
  const themeData = { ...defaultThemeData, ...overrides };
  const baseTheme = createTheme(themeData);
  const theme = createTheme(baseTheme, buttonOverrides(baseTheme, buttons));

  return (
    <React.StrictMode>
      <CssBaseline />
      <ThemeProvider theme={theme}>
        <Suspense fallback={<CircularProgress />}>{children}</Suspense>
      </ThemeProvider>
    </React.StrictMode>
  );
};

export default ThemedComponent;
