import { lazy } from "react";
const AccessLogs = lazy(() => import("../components/accesslogs/AccessLogs"));

const accessLogs = [
  {
    path: "/accesslogs",
    name: "AccessLogs",
    element: AccessLogs,
    roles: ["SysAdmin"],
    exact: true,
    isAnonymous: false,
  },
];

const errorRoutes = [
  {
    path: "*",
    name: "Error - 404",
    element: PageNotFound,
    roles: [],
    exact: true,
    isAnonymous: false,
  },
];

const allRoutes = [
  ...accessLogs,
  ...errorRoutes,
];

export default allRoutes;
