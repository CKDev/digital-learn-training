import { Alert, Snackbar, TextField, Typography } from "@mui/material";
import React, { useState } from "react";
import { updateCourseMaterial } from "@api/CourseMaterialsApi";

const SortOrderInput = ({ enabled, course, onSortOrderChange }) => {
  const defaultSnackbarData = {
    open: false,
    message: "",
    severity: "info",
  };
  const [sortOrder, setSortOrder] = useState(course.sortOrder);
  const [error, setError] = useState("");
  const [snackbarData, setSnackbarData] = useState(defaultSnackbarData);

  const handleBlur = async () => {
    if (sortOrder !== course.sortOrder) {
      const payload = JSON.stringify({
        course_material: { sort_order: sortOrder },
      });
      let response = await updateCourseMaterial(course.id, payload, false);

      if (response.success) {
        onSortOrderChange(course.id, sortOrder);
        setSnackbarData({
          open: true,
          message: "Sort Order Updated!",
          severity: "success",
        });
      } else {
        setSnackbarData({
          open: true,
          message: response.message,
          severity: "error",
        });
      }
    }
  };

  const validSortOrder = (value) => !isNaN(Number(value)) && Number(value) > 0;

  const handleChange = (event) => {
    const value = event.target.value;
    setSortOrder(value);

    if (!validSortOrder(value)) {
      setError("Invalid sort order");
    } else {
      setError("");
    }
  };

  const handleKeyDown = (event) => {
    if (event.key === "Enter" && validSortOrder(event.target.value)) {
      event.target.blur(); // Handle blur w/ blur event
    }
  };

  const handleSnackbarClose = (_event, _reason) => {
    setSnackbarData({ ...snackbarData, open: false });
  };

  const handleSortOrderClick = () => {
    if (enabled) {
      return;
    }
    setSnackbarData({
      open: true,
      message: "Sort Order can only be changed while filtering by Category",
      severity: "error",
    });
  };

  return (
    <>
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
      {enabled ? (
        <TextField
          value={sortOrder}
          disabled={!enabled}
          onChange={handleChange}
          onBlur={handleBlur}
          onKeyDown={handleKeyDown}
          error={error != ""}
        />
      ) : (
        <Typography onClick={handleSortOrderClick}>{sortOrder}</Typography>
      )}
    </>
  );
};

export default SortOrderInput;
