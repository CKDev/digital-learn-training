import React, { useState } from "react";
import { DataGrid } from "@mui/x-data-grid";
import { Box, Grid2 as Grid, IconButton } from "@mui/material";
import EditRoundedIcon from "@mui/icons-material/EditRounded";

const CourseMaterials = ({ courseMaterials }) => {
  const [courses, setCourses] = useState(courseMaterials);

  const handleRowsReorder = (sourceIndex, destinationIndex) => {
    const reorderedCourses = [...courses];
    const [movedRow] = reorderedCourses.splice(sourceIndex, 1);
    reorderedCourses.splice(destinationIndex, 0, movedRow);
    setCourses(reorderedCourses);
  };

  const statusStrings = {
    D: "Draft",
    P: "Published",
    A: "Archived",
  };

  const columns = [
    { field: "sortOrder", headerName: "Order", flex: 0.5 },
    { field: "title", headerName: "Title", flex: 1 },
    {
      field: "status",
      headerName: "Status",
      flex: 0.5,
      valueGetter: (value, row) => statusStrings[row.status],
    },
    { field: "category", headerName: "Category", flex: 1 },
    {
      field: "actions",
      headerName: "Edit",
      sortable: false,
      flex: 0.5,
      renderCell: (params) => (
        <IconButton
          aria-label="edit"
          size="small"
          onClick={() => handleEdit(params.row.id)}
        >
          <EditRoundedIcon />
        </IconButton>
      ),
    },
  ];

  const paginationModel = { page: 0, pageSize: 10 };

  return (
    <Box sx={{ minHeight: 400, width: "100%" }}>
      <Grid container direction="column">
        <DataGrid
          columns={columns}
          rows={courses}
          onRowsReorder={handleRowsReorder}
          rowReordering
          rowHeight={40}
          pagination
          disableRowSelectionOnClick
          initialState={{ pagination: { paginationModel } }}
          pageSizeOptions={[10, 20, 50]}
        />
      </Grid>
    </Box>
  );
};

export default CourseMaterials;
