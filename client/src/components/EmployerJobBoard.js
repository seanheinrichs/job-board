// React & Redux
import React, { useEffect, useState, Fragment } from "react";
import { useDispatch, useSelector } from "react-redux";

// Actions
import { getEmployerJobsRequest, browseCategoriesRequest, deleteJobRequest } from "../state/jobs/jobActions";

// Selectors
import { jobsListSelector, jobListIsLoadingSelector, jobIsSubmittingSelector } from "../state/jobs/jobSelectors";

// MaterialUI
import {
  Button,
  Grid,
  IconButton,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Typography,
  makeStyles,
} from "@material-ui/core";
import DeleteIcon from "@material-ui/icons/Delete";
import EditIcon from "@material-ui/icons/Edit";

// Components
import LoadingScreen from "./LoadingScreen";
import CreateJobFormDialog from "../forms/CreateJobFormDialog";
import CreateCategoryFormDialog from "../forms/CreateCategoryFormDialog";

// Util
import { isEmpty, findIndex, get, capitalize } from "lodash";

// TODO: Limit number of jobs an employer can list (based on subscription level)
// TODO: Take userName from state (just hardcoded currently to test)
const currentUserName = "AlexeiAdcocks";

const useStyles = makeStyles((theme) => ({
  margin: {
    margin: theme.spacing(1),
  },
  padding: {
    marginTop: theme.spacing(3),
    marginBottom: theme.spacing(3),
  },
}));

function EmployerJobBoard() {
  const classes = useStyles();
  const dispatch = useDispatch();

  const jobsList = useSelector(jobsListSelector);
  const isLoadingJobList = useSelector(jobListIsLoadingSelector);
  const isSubmitting = useSelector(jobIsSubmittingSelector);

  const [createJobFormOpen, setCreateJobFormOpen] = useState(false);
  const [createCategoryFormOpen, setCreateCategoryFormOpen] = useState(false);

  // Check for jobsList on page load
  useEffect(() => {
    if (isEmpty(jobsList)) {
      dispatch(getEmployerJobsRequest(currentUserName));
      dispatch(browseCategoriesRequest());
    }
  }, []);

  // Check for jobsList every time user creates a new job
  useEffect(() => {
    dispatch(getEmployerJobsRequest(currentUserName));
    dispatch(browseCategoriesRequest());
  }, [isSubmitting]);

  return (
    <Fragment>
      {isLoadingJobList ? (
        <LoadingScreen fullScreen={false} message={"Loading jobs..."} />
      ) : (
        <Fragment>
          <CreateJobFormDialog
            userName={currentUserName}
            open={createJobFormOpen}
            close={() => setCreateJobFormOpen(false)}
          />
          <CreateCategoryFormDialog open={createCategoryFormOpen} close={() => setCreateCategoryFormOpen(false)} />
          <Typography align="center" variant="h3">
            Your Job Listings
          </Typography>
          <Grid container justify="center" spacing={2}>
            <Grid item xs={12} sm={6} md={3}>
              <Button
                className={classes.padding}
                fullWidth
                variant="outlined"
                onClick={() => setCreateJobFormOpen(true)}
              >
                POST A JOB
              </Button>
            </Grid>
            <Grid item xs={12} sm={6} md={3}>
              <Button
                className={classes.padding}
                fullWidth
                variant="outlined"
                onClick={() => setCreateCategoryFormOpen(true)}
              >
                ADD A CATEGORY
              </Button>
            </Grid>
          </Grid>
          {isEmpty(jobsList) ? (
            <Typography align="center">You don't have any job listings posted yet...</Typography>
          ) : (
            <Table size="medium">
              <TableHead>
                <TableRow>
                  <TableCell align="center">Job ID</TableCell>
                  <TableCell align="center">Title</TableCell>
                  <TableCell align="center">Description</TableCell>
                  <TableCell align="center">Category</TableCell>
                  <TableCell align="center">Employees Needed</TableCell>
                  <TableCell align="center">View Applicants</TableCell>
                  <TableCell align="center">Edit Job</TableCell>
                  <TableCell align="center">Delete Job</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {jobsList.map((job, key) => (
                  <TableRow key={key}>
                    <TableCell align="center">{job.jobID}</TableCell>
                    <TableCell align="center">{job.title}</TableCell>
                    <TableCell align="center">{job.description}</TableCell>
                    <TableCell align="center">{job.categoryName}</TableCell>
                    <TableCell align="center">{job.employeesNeeded}</TableCell>
                    <TableCell>
                      <Button variant="outlined" color="primary">
                        APPLICANTS
                      </Button>
                    </TableCell>
                    <TableCell>
                      <IconButton className={classes.margin} size="medium">
                        <EditIcon color="primary" />
                      </IconButton>
                    </TableCell>
                    <TableCell>
                      <IconButton
                        className={classes.margin}
                        size="medium"
                        onClick={() => dispatch(deleteJobRequest(job.jobID))}
                        disabled={isSubmitting}
                      >
                        <DeleteIcon color="secondary" />
                      </IconButton>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </Fragment>
      )}
    </Fragment>
  );
}

export default EmployerJobBoard;
