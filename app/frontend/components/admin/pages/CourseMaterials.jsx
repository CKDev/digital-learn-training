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
} from "@mui/material";
import { DragDropContext, Droppable, Draggable } from "@hello-pangea/dnd";
import {
  ArrowDropUpRounded,
  ArrowDropDownRounded,
  DragHandleRounded,
  EditRounded,
} from "@mui/icons-material";

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

  const handleDragEnd = (result) => {
    if (!result.destination) return;

    const reorderedCourses = [...courses];
    const [removed] = reorderedCourses.splice(result.source.index, 1);
    reorderedCourses.splice(result.destination.index, 0, removed);

    // Update sortOrder based on new position
    reorderedCourses.forEach((course, index) => {
      course.sortOrder = index + 1;
    });

    setCourses(reorderedCourses);

    // Update the backend with the new order
    const updatedOrder = reorderedCourses.map((course, index) => ({
      id: course.id,
      order: index, // Assuming the backend expects an order field
    }));

    // Replace this with your actual API call
    updateBackendOrder(updatedOrder)
      .then(() => {
        console.log("Order updated successfully!");
      })
      .catch((error) => {
        console.error("Error updating order:", error);
      });
  };

  const handleSort = (field) => {
    const isAsc = sortField === field && sortDirection === "asc";
    setSortField(field);
    setSortDirection(isAsc ? "desc" : "asc");
  };

  const handleChangePage = (event, newPage) => {
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
        const valueA = a[sortField].toString().toLowerCase();
        const valueB = b[sortField].toString().toLowerCase();

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

  return (
    <Paper>
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
        <DragDropContext onDragEnd={handleDragEnd}>
          <Droppable droppableId="courses">
            {(provided) => (
              <Table {...provided.droppableProps} ref={provided.innerRef}>
                <TableHead>
                  <TableRow>
                    <TableCell />
                    <TableCell>
                      <Typography>Sort Order</Typography>
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
                  {paginatedCourses.map((course, index) => (
                    <Draggable
                      key={course.id}
                      draggableId={course.id.toString()}
                      index={index}
                    >
                      {(provided) => (
                        <TableRow
                          ref={provided.innerRef}
                          {...provided.draggableProps}
                          {...provided.dragHandleProps}
                        >
                          <TableCell>
                            <IconButton>
                              <DragHandleRounded />
                            </IconButton>
                          </TableCell>
                          <TableCell>{course.sortOrder}</TableCell>
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
                      )}
                    </Draggable>
                  ))}
                  {provided.placeholder}
                </TableBody>
              </Table>
            )}
          </Droppable>
        </DragDropContext>
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
