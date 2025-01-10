import React, { useState } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TablePagination,
  Paper,
  IconButton,
  TextField,
  MenuItem,
  Grid2 as Grid,
  Typography,
  Box,
  Button,
} from "@mui/material";
import {
  ArrowDropUpRounded,
  ArrowDropDownRounded,
  EditRounded,
  AddCircleRounded,
} from "@mui/icons-material";
import SortOrderInput from "../course_materials/SortOrderInput";

export const STATUS_MAP = {
  D: "Draft",
  P: "Published",
  A: "Archived",
};

const CourseMaterials = ({ courseMaterials }) => {
  const [courses, setCourses] = useState(courseMaterials);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [sortField, setSortField] = useState(null);
  const [sortDirection, setSortDirection] = useState("asc");
  const [filters, setFilters] = useState({ status: "", category: "" });

  const handleSort = (field) => {
    const isAsc = sortField === field && sortDirection === "asc";
    setSortField(field);
    setSortDirection(isAsc ? "desc" : "asc");
  };

  const handleChangePage = (_event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const handleFilterChange = (key, value) => {
    setFilters((prev) => ({ ...prev, [key]: value }));
    setPage(0); // Reset pagination when filtering
  };

  const applyFiltersAndSorting = (data) => {
    // Apply filters
    let filtered = data.filter(
      (course) =>
        (!filters.status || course.status === filters.status) &&
        (!filters.category || course.category === filters.category)
    );

    // Apply sorting
    if (sortField) {
      filtered = filtered.sort((a, b) => {
        const valueA = isNaN(Number(a[sortField]))
          ? a[sortField].toString().toLowerCase()
          : Number(a[sortField]);
        const valueB = isNaN(Number(b[sortField]))
          ? b[sortField].toString().toLowerCase()
          : Number(b[sortField]);

        if (valueA < valueB) return sortDirection === "asc" ? -1 : 1;
        if (valueA > valueB) return sortDirection === "asc" ? 1 : -1;
        return 0;
      });
    }

    return filtered;
  };

  const filteredAndSortedCourses = applyFiltersAndSorting(courses);

  // Paginate courses
  const paginatedCourses = filteredAndSortedCourses.slice(
    page * rowsPerPage,
    page * rowsPerPage + rowsPerPage
  );

  const renderSortIndicator = (field) => {
    if (sortField !== field) return <Box width="24px" />; // Placeholder to avoid shifting
    return sortDirection === "asc" ? (
      <ArrowDropUpRounded />
    ) : (
      <ArrowDropDownRounded />
    );
  };

  const handleSortOrderChange = (courseId, newOrder) => {
    let updatedCourses = [...courses]; // Create copy of courses
    let courseIndex = updatedCourses.findIndex(
      (course) => course.id === courseId
    ); // Find course index
    let updatedCourse = { ...updatedCourses[courseIndex], sortOrder: newOrder }; // Create updated copy of course
    updatedCourses[courseIndex] = updatedCourse;
    setCourses(updatedCourses);
  };

  return (
    <Paper elevation={0}>
      <Button
        variant="text"
        size="small"
        startIcon={<AddCircleRounded />}
        href="/admin/courses/new"
      >
        Add New Course
      </Button>
      <div style={{ display: "flex", gap: "1rem", padding: "1rem" }}>
        <TextField
          label="Filter by Status"
          select
          value={filters.status}
          onChange={(e) => handleFilterChange("status", e.target.value)}
          fullWidth
        >
          <MenuItem value="">All</MenuItem>
          {Object.keys(STATUS_MAP).map((key) => (
            <MenuItem key={key} value={key}>
              {STATUS_MAP[key]}
            </MenuItem>
          ))}
        </TextField>
        <TextField
          label="Filter by Category"
          select
          value={filters.category}
          onChange={(e) => handleFilterChange("category", e.target.value)}
          fullWidth
        >
          <MenuItem value="">All</MenuItem>
          {[...new Set(courses.map((course) => course.category))].map(
            (category) => (
              <MenuItem key={category} value={category}>
                {category}
              </MenuItem>
            )
          )}
        </TextField>
      </div>
      <TableContainer>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell
                width="100px"
                onClick={() => handleSort("sortOrder")}
                style={{ cursor: "pointer" }}
              >
                <Grid container flexWrap={"nowrap"} alignItems={"center"}>
                  <Typography>Sort Order</Typography>
                  {renderSortIndicator("sortOrder")}
                </Grid>
              </TableCell>
              <TableCell
                onClick={() => handleSort("title")}
                style={{ cursor: "pointer" }}
              >
                <Grid container>
                  <Typography>Title</Typography>
                  {renderSortIndicator("title")}
                </Grid>
              </TableCell>
              <TableCell
                onClick={() => handleSort("status")}
                style={{ cursor: "pointer" }}
              >
                <Grid container>
                  <Typography>Status</Typography>
                  {renderSortIndicator("status")}
                </Grid>
              </TableCell>
              <TableCell
                onClick={() => handleSort("category")}
                style={{ cursor: "pointer" }}
              >
                <Grid container>
                  <Typography>Category</Typography>
                  {renderSortIndicator("category")}
                </Grid>
              </TableCell>
              <TableCell>
                <Typography>Edit</Typography>
              </TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {paginatedCourses.map((course) => (
              <TableRow key={`course-materials-row-${course.id}`}>
                <TableCell>
                  <SortOrderInput
                    enabled={filters["category"] !== ""}
                    key={`sort-order-input-${course.id}`}
                    course={course}
                    onSortOrderChange={handleSortOrderChange}
                  />
                </TableCell>
                <TableCell>{course.title}</TableCell>
                <TableCell>{STATUS_MAP[course.status]}</TableCell>
                <TableCell>{course.category}</TableCell>
                <TableCell>
                  <IconButton
                    href={`/admin/courses/${course.friendlyId}/edit`}
                    aria-label="Edit Course"
                  >
                    <EditRounded />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      <TablePagination
        rowsPerPageOptions={[10, 25, 50]}
        component="div"
        count={filteredAndSortedCourses.length}
        rowsPerPage={rowsPerPage}
        page={page}
        onPageChange={handleChangePage}
        onRowsPerPageChange={handleChangeRowsPerPage}
      />
    </Paper>
  );
};

export default CourseMaterials;
