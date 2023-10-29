const routes = [
  {
    path: "/",
    component: () => import("pages/IndexPage.vue")
  },
  {
    name: "LoginPage",
    path: "/login",
    component: () => import("pages/LoginPage.vue")
  },
  {
    name: "Signup",
    path: "/register",
    component: () => import("pages/SignUp.vue")
  },

  {
    name: "Dashboard",
    path: "/dashboard",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      {
        name: "index",
        path: "",
        component: () => import("pages/Dashboard/IndexDashboard.vue")
      },
      {
        name: "alunos",
        path: "",
        component: () => import("pages/Dashboard/AlunosDashBoard.vue")
      }
    ]
  },

  // {
  //   name: "DashboardIndex",
  //   path: "/dashboard",
  //   component: () => import("layouts/DashBoardTemplate.vue"),
  //   children: {
  //     path: "index",
  //     component: () => import("pages/Dashboard/IndexDashboard.vue")
  //   }
  // },
  {
    name: "UserIndex",
    path: "/user",
    component: () => import("pages/UserIndex.vue")
  },

  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue")
  }
];

export default routes;
