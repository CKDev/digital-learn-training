import React from "react";
import { useTheme } from "@mui/material/styles";

function ThemedIcon({
  iconClass: Icon,
  color = "primary",
  size = "medium",
  ...props
}) {
  const theme = useTheme();

  // Resolve the color from the theme
  const iconColor = theme.palette.iconColor || color;

  return (
    <Icon
      style={{
        color: iconColor,
        fontSize: size === "small" ? 20 : size === "large" ? 40 : 24,
      }}
      {...props}
    />
  );
}

export default ThemedIcon;
