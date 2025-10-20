import bootstrap from 'bootstrap';

// Apply collapsed state immediately to prevent flash
(function() {
  const sidebarCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
  if (sidebarCollapsed) {
    document.documentElement.classList.add('sidebar-will-collapse');
  }
})();

document.addEventListener('turbo:load', () => {
  initializeSidebar();
  initializeSidebarDropdowns();
});

function initializeSidebar() {
  const sidebarToggle = document.querySelector('[data-sidebar-toggle]');
  const sidebar = document.getElementById('sidebar');
  const content = document.querySelector('.container-fluid.content');

  if (sidebarToggle && sidebar && content) {
    // Check localStorage for sidebar state
    const sidebarCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';

    if (sidebarCollapsed) {
      sidebar.classList.add('collapsed');
      content.classList.add('sidebar-collapsed');
    }

    // Remove the pre-render class
    document.documentElement.classList.remove('sidebar-will-collapse');

    sidebarToggle.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      content.classList.toggle('sidebar-collapsed');

      // Save state to localStorage
      const isCollapsed = sidebar.classList.contains('collapsed');
      localStorage.setItem('sidebarCollapsed', isCollapsed);

      // Clean up all dropdown displays when toggling
      sidebar.querySelectorAll('.dropdown-menu').forEach(menu => {
        menu.style.display = '';
      });

      // Dispose and reinitialize tooltips when toggling
      updateTooltips();
    });

    // Initialize tooltips on page load
    updateTooltips();
  }
}

function updateTooltips() {
  // Dispose existing tooltips
  const existingTooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  existingTooltips.forEach(el => {
    const tooltip = bootstrap.Tooltip.getInstance(el);
    if (tooltip) {
      tooltip.dispose();
    }
  });

  // Only enable tooltips when sidebar is collapsed
  const sidebar = document.getElementById('sidebar');
  if (sidebar && sidebar.classList.contains('collapsed')) {
    const tooltipTriggerList = document.querySelectorAll('.sidebar [data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(el => {
      new bootstrap.Tooltip(el);
    });
  }
}

function initializeSidebarDropdowns() {
  const sidebar = document.getElementById('sidebar');
  if (!sidebar) return;

  // Initialize all dropdowns in the sidebar when expanded
  const dropdownElementList = sidebar.querySelectorAll('.dropdown-toggle');
  dropdownElementList.forEach(dropdownToggleEl => {
    new bootstrap.Dropdown(dropdownToggleEl, {
      autoClose: true
    });
  });

  // Handle hover behavior for collapsed sidebar
  initializeCollapsedDropdownHover();
}

function initializeCollapsedDropdownHover() {
  const sidebar = document.getElementById('sidebar');
  if (!sidebar) return;

  sidebar.querySelectorAll('.nav-item.dropdown').forEach(dropdownItem => {
    const dropdownMenu = dropdownItem.querySelector('.dropdown-menu');
    const dropdownToggle = dropdownItem.querySelector('.dropdown-toggle');

    if (!dropdownMenu || !dropdownToggle) return;

    let hideTimeout;

    const showMenu = () => {
      clearTimeout(hideTimeout);
      if (sidebar.classList.contains('collapsed')) {
        // Hide all other dropdowns first
        sidebar.querySelectorAll('.dropdown-menu').forEach(menu => {
          if (menu !== dropdownMenu) {
            menu.style.display = 'none';
          }
        });
        dropdownMenu.style.display = 'block';
      }
    };

    const hideMenu = () => {
      hideTimeout = setTimeout(() => {
        if (sidebar.classList.contains('collapsed')) {
          dropdownMenu.style.display = 'none';
        }
      }, 300); // 300ms delay before hiding
    };

    // Prevent Bootstrap dropdown from working when collapsed
    dropdownToggle.addEventListener('click', (e) => {
      if (sidebar.classList.contains('collapsed')) {
        e.preventDefault();
        e.stopPropagation();
      }
    });

    // Show on hover over the nav item
    dropdownItem.addEventListener('mouseenter', showMenu);

    // Keep showing when hovering over the menu
    dropdownMenu.addEventListener('mouseenter', showMenu);

    // Hide when leaving the nav item
    dropdownItem.addEventListener('mouseleave', hideMenu);

    // Hide when leaving the menu
    dropdownMenu.addEventListener('mouseleave', hideMenu);
  });
}
