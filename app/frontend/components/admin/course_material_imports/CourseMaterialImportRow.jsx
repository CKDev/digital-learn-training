import { Button, Grid2 as Grid, Paper, Typography } from "@mui/material";
import React from "react";
import { importCourseMaterial } from "@api/CourseMaterialsApi";
import { unimportCourseMaterial } from "../../api/CourseMaterialsApi";

const CourseMaterialImportRow = ({
  courseMaterial,
  isImported,
  onImport,
  onUnimport,
}) => {
  const handleImport = async () => {
    let response = await importCourseMaterial(courseMaterial.id);

    if (response.success) {
      onImport(courseMaterial.id);
    } else {
      // TODO: Show snackbar
    }
  };

  const handleUnimport = async () => {
    let response = await unimportCourseMaterial(courseMaterial.id);

    if (response.success) {
      onUnimport(courseMaterial.id);
    } else {
      // TODO: Show snackbar
    }
  };

  return (
    <Paper sx={{ padding: 1 }}>
      <Grid container alignItems="center" justifyContent={"space-between"}>
        <Typography>{courseMaterial.title}</Typography>
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
