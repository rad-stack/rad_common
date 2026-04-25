Rails.application.config.session_store :cookie_store,
                                       key: "_#{Rails.application.class.module_parent.to_s.underscore}_session",
                                       expire_after: 2.weeks
