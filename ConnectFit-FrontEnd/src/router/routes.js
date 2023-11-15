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
        name: "IndexDashboard",
        path: "index",
        component: () => import("pages/Dashboard/IndexDashboard.vue")
      },
      {
        name: "AlunoDetail",
        path: "alunos/:id",
        component: () => import("pages/Dashboard/Alunos/AlunoDetail.vue")
      },
      {
        name: "AlunosDashboard",
        path: "alunos",
        component: () => import("pages/Dashboard/Alunos/AlunosDashboard.vue")
      },
      {
        name: "ExercicioCreate",
        path: "exercicios/create",
        component: () =>
          import("pages/Dashboard/Exercicios/ExercicioCreate.vue")
      },
      {
        name: "ExerciciosDashboard",
        path: "exercicios",
        component: () =>
          import("pages/Dashboard/Exercicios/ExerciciosDashboard.vue")
      }
    ]
  },
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
