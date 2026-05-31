import React, { useRef, useState } from "react";
import {
  Alert,
  Box,
  Button,
  Grid2 as Grid,
  Paper,
  Stack,
  TextField,
  Typography,
} from "@mui/material";
import { updateOrganizationSettings } from "@api/OrganizationSettingsApi";

const DEFAULT_PALETTE = {
  primary: { main: "#01579B", light: "#29B6F6" },
  info: { main: "#548687", dark: "#006064", contrastText: "#FFFFFF" },
  iconColor: "rgba(0, 0, 0, 0.56)",
};

const OrganizationSettings = ({
  palette: initialPalette,
  headerLogoUrl: initialHeaderLogoUrl,
  footerLogoUrl: initialFooterLogoUrl,
}) => {
  const stored = initialPalette || {};
  const [palette, setPalette] = useState({
    primary: {
      main: stored.primary?.main ?? DEFAULT_PALETTE.primary.main,
      light: stored.primary?.light ?? DEFAULT_PALETTE.primary.light,
    },
    info: {
      main: stored.info?.main ?? DEFAULT_PALETTE.info.main,
      dark: stored.info?.dark ?? DEFAULT_PALETTE.info.dark,
      contrastText: stored.info?.contrastText ?? DEFAULT_PALETTE.info.contrastText,
    },
    iconColor: stored.iconColor ?? DEFAULT_PALETTE.iconColor,
  });

  const [headerLogoUrl, setHeaderLogoUrl] = useState(initialHeaderLogoUrl);
  const [footerLogoUrl, setFooterLogoUrl] = useState(initialFooterLogoUrl);
  const [headerLogoFile, setHeaderLogoFile] = useState(null);
  const [footerLogoFile, setFooterLogoFile] = useState(null);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);

  const headerLogoInputRef = useRef(null);
  const footerLogoInputRef = useRef(null);

  const setNestedColor = (section, key) => (e) => {
    const value = e.target.value;
    setPalette((prev) => ({
      ...prev,
      [section]: { ...prev[section], [key]: value },
    }));
  };

  const handleHeaderLogoChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setHeaderLogoFile(file);
    setHeaderLogoUrl(URL.createObjectURL(file));
  };

  const handleFooterLogoChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setFooterLogoFile(file);
    setFooterLogoUrl(URL.createObjectURL(file));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    setError(null);
    setSuccess(false);

    const data = new FormData();
    data.append("organization[palette][primary][main]", palette.primary.main);
    data.append("organization[palette][primary][light]", palette.primary.light);
    data.append("organization[palette][info][main]", palette.info.main);
    data.append("organization[palette][info][dark]", palette.info.dark);
    data.append("organization[palette][info][contrastText]", palette.info.contrastText);
    data.append("organization[palette][iconColor]", palette.iconColor);

    if (headerLogoFile) {
      data.append("organization[header_logo]", headerLogoFile, headerLogoFile.name);
    }
    if (footerLogoFile) {
      data.append("organization[footer_logo]", footerLogoFile, footerLogoFile.name);
    }

    const response = await updateOrganizationSettings(data);
    setSubmitting(false);

    if (response.success) {
      setSuccess(true);
      setHeaderLogoFile(null);
      setFooterLogoFile(null);
    } else {
      setError(response.message);
    }
  };

  const ColorField = ({ label, value, onChange }) => (
    <Stack direction="row" spacing={1.5} alignItems="center">
      <input
        type="color"
        value={value.startsWith("#") ? value : "#000000"}
        onChange={onChange}
        style={{ width: 36, height: 36, cursor: "pointer", border: "none", padding: 0, background: "none" }}
        title={label}
      />
      <TextField
        label={label}
        value={value}
        onChange={onChange}
        size="small"
        sx={{ flex: 1 }}
      />
    </Stack>
  );

  const LogoSection = ({ title, currentUrl, inputRef, onFileChange }) => (
    <Box>
      <Typography variant="subtitle1" gutterBottom fontWeight="medium">
        {title}
      </Typography>
      {currentUrl ? (
        <Box
          sx={{
            mb: 1.5,
            p: 1,
            border: "1px solid",
            borderColor: "divider",
            borderRadius: 1,
            display: "inline-block",
          }}
        >
          <img
            src={currentUrl}
            alt={title}
            style={{ maxHeight: 80, maxWidth: 220, display: "block" }}
          />
        </Box>
      ) : (
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1.5 }}>
          No logo uploaded
        </Typography>
      )}
      <input
        type="file"
        accept="image/png,image/jpeg,image/gif,image/webp"
        ref={inputRef}
        onChange={onFileChange}
        style={{ display: "none" }}
      />
      <Button
        variant="outlined"
        size="small"
        onClick={() => inputRef.current?.click()}
      >
        {currentUrl ? "Change Logo" : "Upload Logo"}
      </Button>
    </Box>
  );

  return (
    <Box component="form" onSubmit={handleSubmit}>
      <Typography variant="h5" gutterBottom>
        Organization Settings
      </Typography>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}
      {success && (
        <Alert severity="success" sx={{ mb: 2 }}>
          Settings saved successfully.
        </Alert>
      )}

      <Stack spacing={3}>
        <Paper elevation={0} variant="outlined" sx={{ p: 3 }}>
          <Typography variant="h6" gutterBottom>
            Theme Colors
          </Typography>
          <Grid container spacing={3}>
            <Grid size={6}>
              <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                Primary
              </Typography>
              <Stack spacing={2}>
                <ColorField
                  label="Primary (Main)"
                  value={palette.primary.main}
                  onChange={setNestedColor("primary", "main")}
                />
                <ColorField
                  label="Primary (Light)"
                  value={palette.primary.light}
                  onChange={setNestedColor("primary", "light")}
                />
              </Stack>
            </Grid>
            <Grid size={6}>
              <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                Info / Accent
              </Typography>
              <Stack spacing={2}>
                <ColorField
                  label="Info (Main)"
                  value={palette.info.main}
                  onChange={setNestedColor("info", "main")}
                />
                <ColorField
                  label="Info (Dark)"
                  value={palette.info.dark}
                  onChange={setNestedColor("info", "dark")}
                />
                <ColorField
                  label="Info (Contrast Text)"
                  value={palette.info.contrastText}
                  onChange={setNestedColor("info", "contrastText")}
                />
              </Stack>
            </Grid>
            <Grid size={12}>
              <Typography variant="subtitle2" color="text.secondary" gutterBottom>
                Other
              </Typography>
              <TextField
                label="Icon Color"
                value={palette.iconColor}
                onChange={(e) =>
                  setPalette((prev) => ({ ...prev, iconColor: e.target.value }))
                }
                size="small"
                helperText="Accepts hex or rgba values (e.g. rgba(0, 0, 0, 0.56))"
                sx={{ width: 320 }}
              />
            </Grid>
          </Grid>
        </Paper>

        <Paper elevation={0} variant="outlined" sx={{ p: 3 }}>
          <Typography variant="h6" gutterBottom>
            Logos
          </Typography>
          <Grid container spacing={4}>
            <Grid size={6}>
              <LogoSection
                title="Header Logo"
                currentUrl={headerLogoUrl}
                inputRef={headerLogoInputRef}
                onFileChange={handleHeaderLogoChange}
              />
            </Grid>
            <Grid size={6}>
              <LogoSection
                title="Footer Logo"
                currentUrl={footerLogoUrl}
                inputRef={footerLogoInputRef}
                onFileChange={handleFooterLogoChange}
              />
            </Grid>
          </Grid>
        </Paper>

        <Box>
          <Button type="submit" variant="contained" disabled={submitting}>
            {submitting ? "Saving…" : "Save Settings"}
          </Button>
        </Box>
      </Stack>
    </Box>
  );
};

export default OrganizationSettings;
