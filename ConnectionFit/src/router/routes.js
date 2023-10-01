const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/IndexPage.vue") }]
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
    name: "UserIndex",
    path: "/user",
    component: () => import("pages/UserIndex.vue")
  },
  {
    name: "Configuration",
    path: "/user/config",
    component: () => import("pages/SignUp.vue")
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue")
  }
];

export default routes;
