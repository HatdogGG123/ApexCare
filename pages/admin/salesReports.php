<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="../../generalStyle.css">
    <style type="text/tailwindcss">
        @theme {
        /* Custom Fonts */
            --font-display: "Plus Jakarta Sans", sans-serif;

            /* Custom Colors */
            --color-primary: #3e5c76;
            --color-secondary: #748cab;
            --color-accent: #f0ebd8;
            --color-primary-dark: #1d2d44;

            --color-dark-blue: #0d1321;
            --color-white: #f2f2f2;
            --color-black: #202020;

            --breakpoint-xs: 30rem;
            --breakpoint-2xl: 100rem;
            --breakpoint-3xl: 150rem;
        }
    </style>
    <title>Admin | Sales Reports</title>
</head>

<body class="relative w-full h-dvh bg-white text-dark-blue text-sm font-display">
    <!-- Main Content -->
    <main class="w-full h-fit min-h-full grid grid-cols-1 divide-x divide-primary/20 lg:grid-cols-[7dvw_auto] xl:lg:grid-cols-[15dvw_auto] 3xl:grid-cols-[400px_auto]">
        <!-- Sidebar -->
        <aside id="sidebar" class="hidden absolute z-50 w-full h-fit bg-secondary text-white p-5 flex flex-col gap-3 divide-y divide-primary/20 lg:block lg:static lg:h-dvh lg:bg-white lg:text-dark-blue overflow-y-scroll scrollbar-none">
            <!-- Logo Container -->
            <section class="flex items-center justify-between lg:justify-center xl:justify-between">
                <a href=" " class="py-3 flex items-center lg:justify-center 2xl:justify-start gap-2">
                    <p class="bg-primary size-10 px-3 py-2 flex items-center justify-center text-white font-semibold rounded-md text-l">AC</p>
                    <p class="text-lg font-medium font-semibold lg:hidden xl:block">ApexCare Pharmacy</p>
                </a>
                <button id="closeSidebarBtn" class="text-accent rounded-md cursor-pointer lg:w-fit h-fit p-2 flex items-center gap-3 lg:hidden 2xl:w-full">
                    <svg class="lucide lucide-x-icon lucide-x size-9" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 6 6 18" />
                        <path d="m6 6 12 12" />
                    </svg>
                </button>
            </section>

            <!-- Profile -->
            <section class="flex flex-col gap-2 w-full h-fit py-3">
                <section class="flex flex-col gap-2">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">My Profile</p>
                    <section class="flex gap-2 items-center">
                        <p class="bg-primary size-10 px-3 py-2 flex items-center justify-center text-white font-medium rounded-md text-xl">RT</p>
                        <section class="flex flex-col">
                            <p class="text-lg font-medium lg:hidden xl:block">Renzo Tolentino</p>
                            <p class="text-white/70 lg:text-gray-500 lg:hidden xl:block">U1213</p>
                        </section>
                    </section>
                </section>

                <section class="w-full mt-10 text-center">
                    <button class="border border-primary rounded-md text-center flex items-center justify-center gap-2 cursor-pointer w-full lg:w-fit xl:w-full h-fit px-3 py-2 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-log-out-icon lucide-log-out size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m16 17 5-5-5-5" />
                            <path d="M21 12H9" />
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                        </svg>
                        <p class="lg:hidden xl:block">Logout</p>
                    </button>
                </section>
            </section>

            <!-- Sidebar Menu List -->
            <section class="divide-y divide-primary/20 flex flex-col gap-4 ">
                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start" title="Dashboard">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Overview</p>
                    <a href="../admin/dashboard.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-layout-dashboard-icon lucide-layout-dashboard size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <rect width="7" height="9" x="3" y="3" rx="1" />
                            <rect width="7" height="5" x="14" y="3" rx="1" />
                            <rect width="7" height="9" x="14" y="12" rx="1" />
                            <rect width="7" height="5" x="3" y="16" rx="1" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Dashboard</p>
                    </a>
                </section>

                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Procurement</p>
                    <a href=" ../admin/supplierManagement.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-handshake-icon lucide-handshake size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8 " stroke-linecap="round" stroke-linejoin="round">
                            <path d="m11 17 2 2a1 1 0 1 0 3-3" />
                            <path d="m14 14 2.5 2.5a1 1 0 1 0 3-3l-3.88-3.88a3 3 0 0 0-4.24 0l-.88.88a1 1 0 1 1-3-3l2.81-2.81a5.79 5.79 0 0 1 7.06-.87l.47.28a2 2 0 0 0 1.42.25L21 4" />
                            <path d="m21 3 1 11h-2" />
                            <path d="M3 3 2 14l6.5 6.5a1 1 0 1 0 3-3" />
                            <path d="M3 4h8" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Supplier Management</p>
                    </a>
                    <a href=" ../admin/orderManagement.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-clipboard-pen-icon lucide-clipboard-pen size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 4h2a2 2 0 0 1 2 2v2" />
                            <path d="M21.34 15.664a1 1 0 1 0-3.004-3.004l-5.01 5.012a2 2 0 0 0-.506.854l-.837 2.87a.5.5 0 0 0 .62.62l2.87-.837a2 2 0 0 0 .854-.506z" />
                            <path d="M8 22H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" />
                            <rect x="8" y="2" width="8" height="4" rx="1" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Order Management</p>
                    </a>
                    <a href=" ../admin/deliveryMangement.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-truck-icon lucide-truck size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2" />
                            <path d="M15 18H9" />
                            <path d="M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.624l-3.48-4.35A1 1 0 0 0 17.52 8H14" />
                            <circle cx="17" cy="18" r="2" />
                            <circle cx="7" cy="18" r="2" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Delivery Management</p>
                    </a>
                    <a href=" ../admin/purchaseRecords.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-receipt-text-icon lucide-receipt-text size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M13 16H8" />
                            <path d="M14 8H8" />
                            <path d="M16 12H8" />
                            <path d="M4 3a1 1 0 0 1 1-1 1.3 1.3 0 0 1 .7.2l.933.6a1.3 1.3 0 0 0 1.4 0l.934-.6a1.3 1.3 0 0 1 1.4 0l.933.6a1.3 1.3 0 0 0 1.4 0l.933-.6a1.3 1.3 0 0 1 1.4 0l.934.6a1.3 1.3 0 0 0 1.4 0l.933-.6A1.3 1.3 0 0 1 19 2a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1 1.3 1.3 0 0 1-.7-.2l-.933-.6a1.3 1.3 0 0 0-1.4 0l-.934.6a1.3 1.3 0 0 1-1.4 0l-.933-.6a1.3 1.3 0 0 0-1.4 0l-.933.6a1.3 1.3 0 0 1-1.4 0l-.934-.6a1.3 1.3 0 0 0-1.4 0l-.933.6a1.3 1.3 0 0 1-.7.2 1 1 0 0 1-1-1z" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Purchase Records</p>
                    </a>
                </section>

                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Sales</p>
                    <a href=" ../admin/salesRecords.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-badge-dollar-sign-icon lucide-badge-dollar-sign size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z" />
                            <path d="M16 8h-6a2 2 0 1 0 0 4h4a2 2 0 1 1 0 4H8" />
                            <path d="M12 18V6" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Sales Records</p>
                    </a>
                    <a href=" ../admin/salesReports.php" class="bg-primary text-white rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-chart-column-icon lucide-chart-column size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M3 3v16a2 2 0 0 0 2 2h16" />
                            <path d="M18 17V9" />
                            <path d="M13 17V5" />
                            <path d="M8 17v-3" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Sales Reports</p>
                    </a>
                </section>

                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Inventory</p>
                    <a href=" ../admin/medicineInventory.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full">
                        <svg class="lucide lucide-warehouse-icon lucide-warehouse size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M18 21V10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1v11" />
                            <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V8a2 2 0 0 1 1.132-1.803l7.95-3.974a2 2 0 0 1 1.837 0l7.948 3.974A2 2 0 0 1 22 8z" />
                            <path d="M6 13h12" />
                            <path d="M6 17h12" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Medicine Inventory</p>
                    </a>
                </section>

                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Staff</p>
                    <a href=" ../admin/userManagement.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
                        <svg class="lucide lucide-user-round-icon lucide-user-round size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="8" r="5" />
                            <path d="M20 21a8 8 0 0 0-16 0" />
                        </svg>
                        <p class="lg:hidden text-start xl:block">Staff Management</p>
                    </a>
                </section>
            </section>
        </aside>

        <!-- Main Content -->
        <section class="w-full h-dvh p-5 grid grid-cols-1 gap-8  md:grid-cols-2 lg:grid-cols-4 xl:gap-3 grid-rows-auto lg:grid-rows-[auto_auto_auto_auto_auto] lg:grid-rows-[auto_auto_100%_100%_100%_100%_auto] overflow-y-scroll scrollbar-thin scrollbar-thumb-sendary">
            <!-- Header -->
            <section class="col-span-full flex items-center justify-between">
                <section class="flex items-center gap-3">
                    <p class="col-span-full flex items-center text-lg font-medium md:text-2xl">Sales Reports</p>
                </section>

                <section class="flex items-center gap-2">
                    <button id="openSidebarBtn" class="bg-primary p-1 size-10 flex items-center justify-center text-white rounded-md lg:hidden">
                        <svg class="lucide lucide-menu-icon lucide-menu size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 5h16" />
                            <path d="M4 12h16" />
                            <path d="M4 19h16" />
                        </svg>
                    </button>
                </section>
            </section>

            <!-- Total Sales Revenue -->
            <section class="col-span-full border border border-gray-400/30 w-full h-fit gap-10 rounded-lg col-span-full flex flex-col justify-between p-3 lg:flex-row">
                <section class="flex flex-col justify-between h-full gap-2">
                    <section class="flex flex-col gap-1">
                        <p class="text-md text-gray-500">Total Sales Revenue</p>
                        <p class="text-4xl font-medium flex items-center md:text-5xl lg:text-6xl"><span class="text-2xl">+</span>₱123,102</p>
                    </section>

                    <!-- Display either one of the report -->
                    <section class="text-xs w-fit flex items-center gap-1 px-5 py-2 rounded-full border border-green-700 bg-green-100 text-green-700">
                        <svg class="lucide lucide-trending-up-icon lucide-trending-up size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 7h6v6" />
                            <path d="m22 7-8.5 8.5-5-5L2 17" />
                        </svg>
                        <p><span>12</span>% Higher than yesterday</p>
                    </section>
                    <section class="text-xs w-fit flex items-center gap-1 px-5 py-2 rounded-full border border-red-700 bg-red-100 text-red-700">
                        <svg class="lucide lucide-trending-down-icon lucide-trending-down size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 17h6v-6" />
                            <path d="m22 17-8.5-8.5-5 5L2 7" />
                        </svg>
                        <p><span>12</span>% Lower than yesterday</p>
                    </section>
                    <section class="flex items-center gap-1 text-gray-500 mt-5">
                        <svg class="lucide lucide-arrow-left-right-icon lucide-arrow-left-right size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M8 3 4 7l4 4" />
                            <path d="M4 7h16" />
                            <path d="m16 21 4-4-4-4" />
                            <path d="M20 17H4" />
                        </svg>
                        <p>100 Successfull Transcations</p>
                    </section>
                </section>

                <section class="bg-secondary/80 h-fit p-2 rounded-md flex flex-wrap">
                    <button class="bg-primary px-3 py-2 rounded-lg text-white grow">Today</button>
                    <button class="px-3 py-2 rounded-lg text-white grow">1 Day ago</button>
                    <button class="px-3 py-2 rounded-lg text-white grow">7 Days ago</button>
                    <button class="px-3 py-2 rounded-lg text-white grow">30 Days ago</button>
                    <button class="px-3 py-2 rounded-lg text-white grow">60 Days ago</button>
                </section>
            </section>

            <!-- Total Amount Spent -->
            <section class="col-span-full border border-gray-400/30 rounded-lg flex flex-col gap-1 p-3 lg:col-span-2 xl:col-span-1">
                <p class="text-gray-500">Overall Amount Spent</p>
                <p class="text-2xl font-medium">₱240,091.00</p>

                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-green-700 bg-green-100 text-green-700">
                    <svg class="lucide lucide-trending-up-icon lucide-trending-up size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 7h6v6" />
                        <path d="m22 7-8.5 8.5-5-5L2 17" />
                    </svg>
                    <p><span>12</span>% Higher than yesterday</p>
                </section>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-red-700 bg-red-100 text-red-700">
                    <svg class="lucide lucide-trending-down-icon lucide-trending-down size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 17h6v-6" />
                        <path d="m22 17-8.5-8.5-5 5L2 7" />
                    </svg>
                    <p><span>12</span>% Lower than yesterday</p>
                </section>
            </section>

            <!-- Total Discount Given -->
            <section class="col-span-full border border-gray-400/30 rounded-lg flex flex-col gap-1 p-3 lg:col-span-2 xl:col-span-1">
                <p class="text-gray-500">Overall Discount Given</p>
                <p class="text-2xl font-medium">₱10,091.00</p>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-green-700 bg-green-100 text-green-700">
                    <svg class="lucide lucide-trending-up-icon lucide-trending-up size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 7h6v6" />
                        <path d="m22 7-8.5 8.5-5-5L2 17" />
                    </svg>
                    <p><span>12</span>% Higher than yesterday</p>
                </section>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-red-700 bg-red-100 text-red-700">
                    <svg class="lucide lucide-trending-down-icon lucide-trending-down size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 17h6v-6" />
                        <path d="m22 17-8.5-8.5-5 5L2 7" />
                    </svg>
                    <p><span>12</span>% Lower than yesterday</p>
                </section>
            </section>

            <!-- Total Profit Gained -->
            <section class="col-span-full border border-gray-400/30 rounded-lg flex flex-col gap-1 p-3 lg:col-span-2 xl:col-span-1">
                <p class="text-gray-500">Overall Profit Gained</p>
                <p class="text-2xl font-medium text-green-600">+₱90,091.00</p>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-green-700 bg-green-100 text-green-700">
                    <svg class="lucide lucide-trending-up-icon lucide-trending-up size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 7h6v6" />
                        <path d="m22 7-8.5 8.5-5-5L2 17" />
                    </svg>
                    <p><span>12</span>% Higher than yesterday</p>
                </section>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-red-700 bg-red-100 text-red-700">
                    <svg class="lucide lucide-trending-down-icon lucide-trending-down size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 17h6v-6" />
                        <path d="m22 17-8.5-8.5-5 5L2 7" />
                    </svg>
                    <p><span>12</span>% Lower than yesterday</p>
                </section>
            </section>

            <!-- Total Amount Lost -->
            <section class="col-span-full border border-gray-400/30 rounded-lg flex flex-col gap-1 p-3 lg:col-span-2 xl:col-span-1">
                <p class="text-gray-500">Overall Amount Lost</p>
                <div class="text-2xl font-medium text-red-700 flex items-center">
                    <div>-</div>
                    <p>₱0.00</p>
                </div>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-green-700 bg-green-100 text-green-700">
                    <svg class="lucide lucide-trending-up-icon lucide-trending-up size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 7h6v6" />
                        <path d="m22 7-8.5 8.5-5-5L2 17" />
                    </svg>
                    <p><span>12</span>% Higher than yesterday</p>
                </section>
                <section class="text-xs w-fit flex items-center gap-1 px-4 py-2 rounded-full border border-red-700 bg-red-100 text-red-700">
                    <svg class="lucide lucide-trending-down-icon lucide-trending-down size-4" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M16 17h6v-6" />
                        <path d="m22 17-8.5-8.5-5 5L2 7" />
                    </svg>
                    <p><span>12</span>% Lower than yesterday</p>
                </section>
            </section>

            <!-- Sales Trend Chart -->
            <section class="col-span-full h-full mt-5 lg:col-span-full xl:col-span-2">
                <p class="text-gray-500 text-lg">Sales Trend</p>
                <div class="w-full"><canvas class="w-full" id="salesTrendChartContainer"></canvas></div>
            </section>


            <!-- Customer Purchase Percentage -->
            <section class="col-span-full mt-5 lg:col-span-full xl:col-span-2">
                <p class="text-gray-500 text-lg">Sales Revenue per Customer</p>
                <div class="w-full"><canvas class="w-full" id="salesPerCustomerTypeContainer"></canvas></div>
            </section>


            <!-- Top 5 Selling Medicine -->
            <section class="col-span-full flex flex-col w-full h-full gap-2 mt-5">
                <p class="text-gray-500 text-lg">Top 5 Selling Medicine</p>
                <div class="border border-secondary/30 rounded-lg w-full h-fit overflow-scroll scrollbar-none">
                    <table class="table-auto w-full h-full">
                        <thead class="">
                            <tr class="bg-secondary text-white">
                                <th class="text-start font-semibold text-md py-4 pl-5 rounded-tl-md">Medicine Name</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 xl:table-cell">Sold Units</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 xl:table-cell">Revenue Amount</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 pr-5 rounded-tr-md hidden md:table-cell">Total Discount Given</th>
                            </tr>
                        </thead>
                        <tbody class="text-sm">
                            <!-- Normal Rows -->
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">1</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="truncate">Biogesic 500ml</p>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 xl:table-cell">₱100.00</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden md:table-cell">₱500.00</td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">2</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="truncate">Biogesic 500ml</p>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 xl:table-cell">₱100.00</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden md:table-cell">₱500.00</td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">3</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="truncate">Biogesic 500ml</p>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 xl:table-cell">₱100.00</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden md:table-cell">₱500.00</td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">4</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="truncate">Biogesic 500ml</p>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 xl:table-cell">₱100.00</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden md:table-cell">₱500.00</td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">5</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="truncate">Biogesic 500ml</p>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 xl:table-cell">₱100.00</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden md:table-cell">₱500.00</td>
                            </tr>

                            <!-- No Sales Record -->
                            <!-- <tr class="h-1 colspan-full">
                                <td colspan="4">
                                    <div class="w-full h-full flex flex-col items-center justify-center gap-2 p-15 text-center">
                                        <img class="size-35 lg:size-100" src="../../../assets/image/empty_sales_record.png" alt="">
                                        <p class="font-semibold">Oops! There are no sales record saved here...</p>
                                        <p class="text-gray-600/80">There are no recorded sales record here. Please create one transaction to see result.</p>
                                        <button class="bg-primary px-4 py-2 rounded-md text-white cursor-pointer">Add Record</button>
                                    </div>
                                </td>
                            </tr> -->

                            <!-- Invisible Row -->
                            <tr class="h-auto col-span-full">
                                <td colspan="3"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

        </section>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../../js/salesTrendChart.js"></script>
    <script src="../../js/salesPerCustomerType.js"></script>
    <script src="../../js/jquery.min.js"></script>
    <script type="module">
        $("#openSidebarBtn").click(() => {
            $("#sidebar").slideDown();
        })
        $("#closeSidebarBtn").click(() => {
            $("#sidebar").slideUp();
        })

        let tooltipMessageToggleBtnCount = $(".toggleToolTipMessageBtn").length;

        for (let index = 0; index < tooltipMessageToggleBtnCount; index++) {
            $(`#toggleToolTipMessageBtn${index + 1}`).click(() => {
                $(`#toggleToolTipMessageBtn${index + 1} > section`).toggle(100);

                setTimeout(() => {
                    if ($(`#toggleToolTipMessageBtn${index + 1} > section`).css("display").toLowerCase() === "block") {
                        $(`#toggleToolTipMessageBtn${index + 1} > section`).toggle(100);
                    }
                }, 5000);
            })
        }
    </script>
</body>


</html>