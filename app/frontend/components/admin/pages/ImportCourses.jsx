import { Box, Grid2 as Grid } from "@mui/material";
import React, { useState } from "react";
import CourseMaterialImportRow from "../course_material_imports/CourseMaterialImportRow";

const ImportCourses = ({ courseMaterials, importedCourseMaterials }) => {
  const [importedIds, setImportedIds] = useState(
    importedCourseMaterials.map((importedMaterial) => importedMaterial.id)
  );

  const handleImport = (importedMaterialId) => {
    console.log("handleImport for: " + importedMaterialId);
    setImportedIds([...importedIds, importedMaterialId]);
  };

  const handleUnimport = (unimportedMaterialId) => {
    console.log("handleUnimport for: " + unimportedMaterialId);
    const newIds = importedIds.filter((id) => id !== unimportedMaterialId);
    setImportedIds(newIds);
  };

  return (
    <Box>
      <Grid container direction="column" gap={1}>
        {courseMaterials.map((courseMaterial) => {
          var isImported = importedIds.includes(courseMaterial.id);
          return (
            <CourseMaterialImportRow
              key={`course-material-import-row-${courseMaterial.id}`}
              courseMaterial={courseMaterial}
              isImported={isImported}
              onImport={handleImport}
              onUnimport={handleUnimport}
            />
          );
        })}
      </Grid>
    </Box>
  );
};

export default ImportCourses;
