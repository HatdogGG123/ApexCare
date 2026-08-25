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
    <title>Admin | Medicine Inventory</title>
</head>

<body class="relative w-full h-dvh bg-white text-dark-blue text-sm font-display">
    <!-- Back to top button -->
    <button id="backToTopBtn" class="fixed bg-secondary z-20 bottom-10 right-10 text-sm text-white flex gap-2 items-center justify-center px-4 py-3 pr-5 rounded-md cursor-pointer">
        <svg class="lucide lucide-arrow-up-from-dot-icon lucide-arrow-up-from-dot size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="m5 9 7-7 7 7" />
            <path d="M12 16V2" />
            <circle cx="12" cy="21" r="1" />
        </svg>
        <p>Back to top</p>
    </button>

    <aside id="inventoryFilterPanel" class="hidden fixed z-60 flex items-end justify-end bg-gray-600/40 w-full h-dvh">
        <!-- Panel Content -->
        <section class="relative z-10 w-full h-[80dvh] bg-white shadow-2xl flex flex-col justify-between font-display lg:h-dvh lg:w-[40%] xl:w-[25%]">
            <!-- Header -->
            <section class="p-5 border-b flex items-center justify-between bg-gray-50/50">
                <section>
                    <h2 class="text-lg font-bold text-gray-900">Filters</h2>
                </section>
                <button type="button" class="closeFilterBtn text-gray-400 hover:text-gray-600 transition-colors p-1">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </section>

            <!-- Form Scroll Area -->
            <section class="p-5 overflow-y-auto flex-1 flex flex-col gap-5 text-sm scrollbar-none">

                <!-- Expiration Date Range Section -->
                <section class="flex flex-col gap-3">
                    <label class="text-xs font-medium text-gray-400">Expiration Date</label>

                    <section class="grid grid-cols-2 gap-3">
                        <!-- From Date Input -->
                        <section>
                            <label class="block text-xs font-semibold text-gray-700 mb-1">From</label>
                            <input type="date" class="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-700 focus:ring-2 focus:ring-secondary focus:outline-none" />
                        </section>

                        <!-- To Date Input -->
                        <section>
                            <label class="block text-xs font-semibold text-gray-700 mb-1">To</label>
                            <input type="date" class="w-full bg-gray-50 border border-gray-300 rounded-lg p-2.5 text-xs text-gray-700 focus:ring-2 focus:ring-secondary focus:outline-none" />
                        </section>
                    </section>
                </section>

                <hr class="border-gray-100">

                <!-- Category 1: Stock Status -->
                <section class="flex flex-col gap-3">
                    <label class="text-xs font-medium text-gray-400">Stock Status</label>

                    <section class="bg-gray-50 p-3 rounded-xl border border-gray-200 flex flex-col gap-2.5">
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="stock_status" value="in_stock" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>In Stock</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="stock_status" value="low_stock" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Low Stock Alert</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="stock_status" value="out_of_stock" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Out of Stock</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="stock_status" value="expired" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Near Expiration / Expired</span>
                        </label>
                    </section>
                </section>

                <!-- Category 2: Prescription Type (Rx Status) -->
                <section class="flex flex-col gap-3">
                    <label class="text-xs font-medium text-gray-400">Prescription Type</label>

                    <section class="bg-gray-50 p-3 rounded-xl border border-gray-200 flex flex-col gap-2.5">
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="rx_type" value="otc" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Over-The-Counter (OTC)</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="rx_type" value="rx" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Prescription Required (Rx)</span>
                        </label>
                    </section>
                </section>

                <!-- Category 3: Dosage Form -->
                <section class="flex flex-col gap-3">
                    <label class="text-xs font-medium text-gray-400">Dosage Form</label>

                    <section class="bg-gray-50 p-3 rounded-xl border border-gray-200 flex flex-col gap-2.5">
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="form" value="tablet" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Tablets</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="form" value="capsule" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Capsules</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="form" value="syrup" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Syrup / Liquid</span>
                        </label>
                        <label class="flex items-center gap-2.5 cursor-pointer text-xs font-medium text-gray-700 hover:text-gray-900">
                            <input type="checkbox" name="form" value="ointment" class="rounded border-gray-300 text-secondary focus:ring-secondary w-4 h-4" />
                            <span>Ointment / Cream</span>
                        </label>
                    </section>
                </section>
            </section>

            <!-- Footer Action Buttons -->
            <section class="p-4 border-t bg-white flex items-center gap-3">
                <button type="reset" class="w-1/3 bg-gray-100 hover:bg-gray-200 text-gray-700 font-medium py-2.5 rounded-lg text-sm transition-colors">
                    Reset
                </button>
                <button type="button" class="w-2/3 bg-[#2d3e50] hover:bg-[#1e2a38] text-white font-medium py-2.5 rounded-lg text-sm transition-colors">
                    Apply Filters
                </button>
            </section>
        </section>
    </aside>

    <!-- Detail View Panel -->
    <aside id="viewDetailPanel" class="hidden fixed top-0 right-0 z-60 bg-gray-900/40 w-dvw h-dvh border-l flex flex-col justify-end font-display transition duration-200 lg:flex-row">
        <!-- Main Content Wrapper -->
        <section class="w-full h-fit flex flex-col gap-6 bg-white p-6 justify-between lg:h-dvh lg:w-[40%] xl:w-[25%]">
            <section class="flex flex-col w-full gap-6 items-start justify-between pb-4">
                <!-- Header & Close Button -->
                <section class="flex items-start justify-between pb-4 w-full">
                    <section>
                        <h2 class="text-xl font-bold text-gray-900 leading-tight">Amoxicillin Trihydrate</h2>
                        <span class="inline-block mt-1 text-xs font-semibold text-gray-500 bg-gray-100 px-2 py-0.5 rounded">
                            500mg Capsule
                        </span>
                    </section>
                    <button class="closeViewDetailPanelBtn text-gray-400 transition-colors cursor-pointer hover:text-gray-600">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </section>

                <!-- Inventory Status Card -->
                <section class="bg-orange-50 border border-orange-200 rounded-xl p-4 flex flex-col gap-2 w-full">
                    <section class="flex items-center justify-between">
                        <span class="text-xs font-medium text-orange-700">Stock Status</span>
                        <span class="bg-orange-200 border border-orange-500 text-orange-700 text-xs font-semibold px-2.5 py-0.5 rounded-full">
                            Low Stock
                        </span>
                    </section>
                    <section class="flex items-baseline gap-1 mt-1">
                        <span class="text-3xl font-extrabold text-gray-900">8</span>
                        <span class="text-sm text-gray-600 font-medium">pcs remaining</span>
                    </section>
                    <p class="text-xs text-orange-800/80 mt-1 flex items-center gap-1">
                        <span>Expiry Date:</span>
                        <span class="font-semibold">November 15, 2026</span>
                    </p>
                </section>

                <!-- Product Details Grid -->
                <section class="flex flex-col gap-3 w-full">
                    <h3 class="text-sm text-gray-400">Product Details</h3>

                    <section class="grid grid-cols-2 gap-3 text-sm">
                        <section class="bg-gray-50 p-3 rounded-lg border border-gray-100">
                            <p class="text-xs text-gray-500">Brand</p>
                            <p class="font-semibold text-gray-800 mt-0.5">Amoxil</p>
                        </section>
                        <section class="bg-gray-50 p-3 rounded-lg border border-gray-100">
                            <p class="text-xs text-gray-500">Category</p>
                            <p class="font-semibold text-gray-800 mt-0.5">Antibiotic</p>
                        </section>
                    </section>

                    <section class="bg-gray-50 p-3 rounded-lg border border-gray-100 text-sm flex flex-col gap-2">
                        <section>
                            <p class="text-xs text-gray-500">Supplier</p>
                            <p class="font-semibold text-gray-800">Zuellig Pharma</p>
                        </section>
                        <section class="border-t border-gray-200 pt-2">
                            <p class="text-xs text-gray-500">Batch Number</p>
                            <p class="text-xs font-semibold text-gray-700 mt-0.5">BN-2026-001</p>
                        </section>
                    </section>
                </section>
            </section>

            <!-- Quick Action Footer -->
            <section class="pt-4 mt-6 flex flex-col gap-2">
                <button id="orderStockBtn" class="w-full bg-primary text-white font-medium py-2.5 px-4 rounded-lg text-sm transition-colors flex items-center justify-center gap-2 cursor-pointer">
                    Order Restock
                </button>
                <button class="closeViewDetailPanelBtn w-full bg-gray-100 hover:bg-gray-200 text-gray-700 font-medium py-2.5 px-4 rounded-lg text-sm transition-colors cursor-pointer">
                    Close Panel
                </button>
            </section>
        </section>

    </aside>

    <!-- Main Content -->
    <main class="w-full h-fit min-h-full grid grid-cols-1 divide-x divide-primary/20 lg:grid-cols-[7dvw_auto] lg:grid-cols-[10dvw_auto] xl:grid-cols-[15dvw_auto] 3xl:grid-cols-[400px_auto]">
        <!-- Sidebar -->
        <aside id="sidebar" class="hidden absolute z-50 w-full h-fit bg-secondary text-white p-5 flex flex-col gap-3 divide-y divide-primary/20 lg:block lg:static lg:h-full lg:bg-white lg:text-dark-blue">
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
                    <button class="border border-primary rounded-md text-center flex items-center justify-center gap-2 cursor-pointer w-full lg:w-fit h-fit px-3 py-2 2xl:w-full hover:bg-secondary/40 transition duration-100">
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
                <section class="py-3 flex flex-col lg:items-center gap-1 xl:items-start">
                    <p class="lg:hidden font-medium text-white/60 xl:block lg:text-dark-blue/30">Overview</p>
                    <a href="../admin/dashboard.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
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
                    <a href=" ../admin/salesReports.php" class="rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full hover:bg-secondary/40 transition duration-100">
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
                    <a href=" ../admin/medicineInventory.php" class="bg-primary text-white rounded-md cursor-pointer lg:w-fit h-fit px-3 py-2 flex items-center gap-3 2xl:w-full">
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
        <section class="w-full h-full p-5 grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-4 lg:gap-3 lg:grid-rows-[auto_auto_12fr]">
            <!-- Header -->
            <section class="col-span-full flex items-center justify-between">
                <section class="flex items-center gap-3">
                    <p class="col-span-full flex items-center text-lg font-medium md:text-2xl">Medicine Inventory</p>
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

            <!-- Search, Filter & Add sales button -->
            <section class="col-span-full flex flex-col gap-2">
                <section class="border border-primary flex items-center gap-2 p-2 pr-3 rounded-md w-full h-fit lg:w-100">
                    <svg class="lucide lucide-search-icon lucide-search size-4.5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                        <path d="m21 21-4.34-4.34" />
                        <circle cx="11" cy="11" r="8" />
                    </svg>
                    <input class="outline-0 text-sm w-full" type="text" name="medicineSearchQuery" id="medicineSearchQueryTxt">
                </section>
            </section>

            <!-- Table records -->
            <section class="col-span-full flex flex-col w-full h-full gap-2">
                <div class="border border-secondary/30 rounded-lg w-full h-full">
                    <table class="table-auto w-full h-full">
                        <thead class="">
                            <tr class="bg-secondary text-white">
                                <th class="text-start font-semibold text-md py-4 pl-5 w-10 rounded-tl-md">ID</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 w-[55%] sm:w-[75%] lg:w-70">Medicine Name</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 w-50 hidden xl:table-cell">Supplier</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 hidden xl:table-cell">Batch Number</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 hidden lg:table-cell">Expirey Date</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 hidden lg:table-cell">Status</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 hidden lg:table-cell">Stock Left</th>
                                <th class="text-start font-semibold text-md py-4 pl-5 pr-5 rounded-tr-md lg:w-50"></th>
                            </tr>
                        </thead>
                        <tbody class="text-sm">
                            <!-- Normal Rows -->
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">1</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="font-semibold truncate">Amoxicillin 500mg Capsule</p>
                                        <section class="text-gray-800/50">
                                            Amoxil | Capsule
                                        </section>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">Zuellig Pharma</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">BN-2026-001</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">January 1, 2027</td>
                                <td class="py-4 pl-5 hidden lg:table-cell">
                                    <p class="bg-red-200 border border-red-600 w-fit py-1 px-4 rounded-full text-red-600 flex items-center justify-center">Out of Stock</p>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">0</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <button id="viewDetailBtn1" class="bg-primary text-white rounded-md cursor pointer flex items-center gap-1 px-3 py-2 cursor-pointer">
                                        <svg class="lucide lucide-eye-icon lucide-eye size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0" />
                                            <circle cx="12" cy="12" r="3" />
                                        </svg>
                                        <p class="hidden md:block">View details</p>
                                    </button>
                                </td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">2</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="font-semibold truncate">Paracetamol 500mg Tablet</p>
                                        <section class="text-gray-800/50">
                                            Biogesic | Tablet
                                        </section>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">Unilab Health</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">BN-2026-042</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">June 26, 2028</td>
                                <td class="py-4 pl-5 hidden lg:table-cell">
                                    <p class="bg-orange-200 border border-orange-600 w-fit px-4 py-1 rounded-full text-orange-600 flex items-center justify-center">Low</p>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">5</td>
                                <td class="max-w-[0] truncate py-4 pl-5 ">
                                    <button class="bg-primary text-white rounded-md cursor pointer flex items-center gap-1 px-3 py-2 cursor-pointer">
                                        <svg class="lucide lucide-eye-icon lucide-eye size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0" />
                                            <circle cx="12" cy="12" r="3" />
                                        </svg>
                                        <p class="hidden md:block">View details</p>
                                    </button>
                                </td>
                            </tr>
                            <tr class="h-1">
                                <td class="max-w-[0] truncate py-4 pl-5">3</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <div>
                                        <p class="font-semibold truncate">Cetirizine HCl 10mg Tablet</p>
                                        <section class="text-gray-800/50">
                                            Allercur | Tablet
                                        </section>
                                    </div>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">United Laboratories</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">BN-2026-108</td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden xl:table-cell">May 1, 2026</td>
                                <td class="py-4 pl-5 hidden lg:table-cell">
                                    <p class="bg-green-200 border border-green-600 w-fit px-4 py-1 rounded-full text-green-600 flex items-center justify-center">Good</p>
                                </td>
                                <td class="max-w-[0] truncate py-4 pl-5 hidden lg:table-cell">1500</td>
                                <td class="max-w-[0] truncate py-4 pl-5">
                                    <button class="bg-primary text-white rounded-md cursor pointer flex items-center gap-1 px-3 py-2 cursor-pointer">
                                        <svg class="lucide lucide-eye-icon lucide-eye size-5" xmlns="http://www.w3.org/2000/svg" width="0" height="0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0" />
                                            <circle cx="12" cy="12" r="3" />
                                        </svg>
                                        <p class="hidden md:block">View details</p>
                                    </button>
                                </td>
                            </tr>

                            <!-- No Stock Left -->
                            <tr class="h-1 colspan-full">
                                <td colspan="7">
                                    <div class="w-full h-full flex flex-col items-center justify-center gap-2 p-15 text-center">
                                        <img class="size-35 lg:size-100" src="../../assets/image/empty_stock.png" alt="">
                                        <p class="font-semibold">Oops! There is no stock left here...</p>
                                        <p class="text-gray-600/80">There is no stock left here, please create orders to fill up the inventory.</p>
                                        <a href=" ../admin/orderManagement.php" class="bg-primary px-4 py-2 rounded-md text-white cursor-pointer">Order Stocks</a>
                                    </div>
                                </td>
                            </tr>
                            <!-- No Stock Left -->
                            <tr class="h-1 colspan-full">
                                <td colspan="7">
                                    <div class="w-full h-full flex flex-col items-center justify-center gap-2 p-15 text-center">
                                        <img class="size-35 lg:size-100" src="../../assets/image/no_result.png" alt="">
                                        <p class="font-semibold">Oops! Can't find what you need.</p>
                                        <p class="text-gray-600/80">There is no results that matches what you're searching. Please try again.</p>
                                    </div>
                                </td>
                            </tr>




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

    <script src="../../js/jquery.min.js"></script>
    <script>
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