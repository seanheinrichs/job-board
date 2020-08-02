import { createSelector } from "reselect";
import { ExpansionPanel } from "@material-ui/core";

const applicantStateSelector = (state) => state.applicantReducer;

export const applicantListSelector = createSelector(
  [applicantStateSelector],
  (applicantState) => applicantState.applicantList
);

export const applicantStatusListSelector = createSelector(
  [applicantStateSelector],
  (applicantState) => applicantState.applicantStatusList
);

export const isLoadingApplicantListSelector = createSelector(
  [applicantStateSelector],
  (applicantState) => applicantState.isLoadingApplicantList
);

export const isLoadingApplicantStatusListSelector = createSelector(
  [applicantStateSelector],
  (applicantState) => applicantState.isLoadingApplicantStatusList
);

export const applicantIsSubmittingSelector = createSelector(
  [applicantStateSelector],
  (applicantState) => applicantState.isSubmitting
);
