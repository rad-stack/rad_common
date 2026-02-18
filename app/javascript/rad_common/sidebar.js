import bootstrap from 'bootstrap';

document.addEventListener('turbo:load', () => {
  initializeSidebar();
  initializeSidebarDropdowns();
  collapseSidebarOnMobile();
});

function collapseSidebarOnMobile() {
  const sidebar = document.getElementById('sidebar');
  const content = document.querySelector('.container-fluid.content');
  const isMobile = window.innerWidth <= 991.98;

  if (sidebar && content && isMobile && !sidebar.classList.contains('collapsed')) {
    // Disable transition for instant collapse on page load
    sidebar.style.transition = 'none';
    content.style.transition = 'none';

    sidebar.classList.add('collapsed');
    content.classList.add('sidebar-collapsed');

    // Re-enable transitions after a frame
    requestAnimationFrame(() => {
      requestAnimationFrame(() => {
        sidebar.style.transition = '';
        content.style.transition = '';
      });
    });
  }
}

function initializeSidebar() {
  const sidebarToggle = document.querySelector('[data-sidebar-toggle]');
  const sidebar = document.getElementById('sidebar');
  const content = document.querySelector('.container-fluid.content');

  if (sidebarToggle && sidebar && content) {

    const collapseSidebar = () => {
      sidebar.classList.add('collapsed');
      content.classList.add('sidebar-collapsed');

      // Store in session to render correct state on next page load
      fetch('/rad_common/user_preferences/sidebar', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ collapsed: true })
      });

      sidebar.querySelectorAll('.dropdown-menu').forEach(menu => {
        menu.style.display = '';
      });

      updateTooltips();
    };

    sidebarToggle.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      content.classList.toggle('sidebar-collapsed');

      const isCollapsed = sidebar.classList.contains('collapsed');

      // Store in session to render correct state on next page load
      fetch('/rad_common/user_preferences/sidebar', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ collapsed: isCollapsed })
      });

      sidebar.querySelectorAll('.dropdown-menu').forEach(menu => {
        menu.style.display = '';
      });

      updateTooltips();
    });

    updateTooltips();
  }
}

function updateTooltips() {
  const existingTooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  existingTooltips.forEach(el => {
    const tooltip = bootstrap.Tooltip.getInstance(el);
    if (tooltip) {
      tooltip.dispose();
    }
  });

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

  // Only initialize Bootstrap dropdowns for mobile header (not sidebar content)
  const mobileHeaderDropdowns = sidebar.querySelectorAll('.sidebar-mobile-header .dropdown-toggle');
  mobileHeaderDropdowns.forEach(dropdownToggleEl => {
    new bootstrap.Dropdown(dropdownToggleEl, {
      autoClose: true
    });
  });

  // Handle sidebar content dropdowns manually (no Bootstrap)
  initializeSidebarContentDropdowns();
}

function initializeSidebarContentDropdowns() {
  const sidebar = document.getElementById('sidebar');
  if (!sidebar) return;

  const sidebarContent = sidebar.querySelector('.sidebar-content');
  if (!sidebarContent) return;

  sidebarContent.querySelectorAll('.nav-item.dropdown').forEach(dropdownItem => {
    const dropdownMenu = dropdownItem.querySelector('.dropdown-menu');
    const dropdownToggle = dropdownItem.querySelector('.dropdown-toggle');

    if (!dropdownMenu || !dropdownToggle) return;

    // Remove Bootstrap's data attribute to prevent auto-initialization
    dropdownToggle.removeAttribute('data-bs-toggle');

    let hideTimeout;
    let isOpen = false;

    const showMenu = () => {
      clearTimeout(hideTimeout);
      isOpen = true;

      // Hide other menus first
      sidebarContent.querySelectorAll('.dropdown-menu').forEach(menu => {
        if (menu !== dropdownMenu) {
          menu.classList.remove('show');
          menu.style.display = '';
          menu.removeAttribute('style');
        }
      });

      if (sidebar.classList.contains('collapsed')) {
        // Collapsed: position fixed to the right of sidebar
        dropdownMenu.classList.add('show');
        dropdownMenu.style.display = 'block';

        const triggerRect = dropdownToggle.getBoundingClientRect();
        const menuHeight = dropdownMenu.offsetHeight;
        const viewportHeight = window.innerHeight;
        const navbarHeight = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--navbar-height')) || 80;

        let topPosition = triggerRect.top;

        if (topPosition + menuHeight > viewportHeight - 20) {
          topPosition = Math.max(navbarHeight + 10, viewportHeight - menuHeight - 20);
        }

        dropdownMenu.style.top = `${topPosition}px`;
      } else {
        // Expanded: show inline
        dropdownMenu.classList.add('show');
        dropdownMenu.style.display = 'block';
      }
    };

    const hideMenu = () => {
      hideTimeout = setTimeout(() => {
        isOpen = false;
        dropdownMenu.classList.remove('show');
        dropdownMenu.style.display = '';
        dropdownMenu.removeAttribute('style');
      }, 150);
    };

    const toggleMenu = () => {
      if (isOpen) {
        clearTimeout(hideTimeout);
        hideMenu();
        // Force immediate hide on click
        clearTimeout(hideTimeout);
        isOpen = false;
        dropdownMenu.classList.remove('show');
        dropdownMenu.style.display = '';
        dropdownMenu.removeAttribute('style');
      } else {
        showMenu();
      }
    };

    // Click handler for expanded state
    dropdownToggle.addEventListener('click', (e) => {
      e.preventDefault();
      if (!sidebar.classList.contains('collapsed')) {
        toggleMenu();
      }
    });

    // Hover handlers for collapsed state
    dropdownItem.addEventListener('mouseenter', () => {
      if (sidebar.classList.contains('collapsed')) {
        showMenu();
      }
    });

    dropdownMenu.addEventListener('mouseenter', () => {
      if (sidebar.classList.contains('collapsed')) {
        clearTimeout(hideTimeout);
      }
    });

    dropdownItem.addEventListener('mouseleave', () => {
      if (sidebar.classList.contains('collapsed')) {
        hideMenu();
      }
    });

    dropdownMenu.addEventListener('mouseleave', () => {
      if (sidebar.classList.contains('collapsed')) {
        hideMenu();
      }
    });
  });
}
