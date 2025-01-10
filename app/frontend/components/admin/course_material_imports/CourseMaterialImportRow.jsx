import React, { useState } from "react";

import {
  Alert,
  Button,
  Grid2 as Grid,
  Paper,
  Snackbar,
  Typography,
} from "@mui/material";
import { importCourseMaterial } from "@api/CourseMaterialsApi";
import { unimportCourseMaterial } from "../../api/CourseMaterialsApi";

const CourseMaterialImportRow = ({
  courseMaterial,
  isImported,
  onImport,
  onUnimport,
}) => {
  const defaultSnackbarData = {
    open: false,
    message: "",
    severity: "info",
  };
  const [snackbarData, setSnackbarData] = useState(defaultSnackbarData);

  const handleImport = async () => {
    let response = await importCourseMaterial(courseMaterial.id);

    if (response.success) {
      onImport(courseMaterial.id);
    } else {
      setSnackbarData({
        open: true,
        message: response.message,
        severity: "error",
      });
    }
  };

  const handleUnimport = async () => {
    let response = await unimportCourseMaterial(courseMaterial.id);

    if (response.success) {
      onUnimport(courseMaterial.id);
    } else {
      setSnackbarData({
        open: true,
        message: response.message,
        severity: "error",
      });
    }
  };

  const handleSnackbarClose = (_event, _reason) => {
    setSnackbarData({ ...snackbarData, open: false });
  };

  return (
    <Paper sx={{ padding: 1 }}>
      <Snackbar
        open={snackbarData.open}
        autoHideDuration={6000}
        onClose={handleSnackbarClose}
        message={snackbarData.message}
      >
        <Alert
          onClose={handleSnackbarClose}
          severity={snackbarData.severity}
          variant="filled"
          sx={{ width: "100%" }}
        >
          {snackbarData.message}
        </Alert>
      </Snackbar>
      <Grid
        container
        alignItems="center"
        justifyContent="space-between"
        gap={2}
        flexWrap="nowrap"
      >
        <Grid container direction="column">
          <Typography>{courseMaterial.title}</Typography>
          <Typography variant="body2">{courseMaterial.summary}</Typography>
        </Grid>
        {isImported ? (
          <Button variant="outlined" onClick={handleUnimport}>
            Unimport
          </Button>
        ) : (
          <Button variant="contained" onClick={handleImport}>
            Import
          </Button>
        )}
      </Grid>
    </Paper>
  );
};

export default CourseMaterialImportRow;
