# :nocov:
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

    
  sidebar :shortcuts do
    div class: "blank_slate_container" do
      ul "Upcoming Flights" do
        DayOfFlight.next_months(3).each do |f|
          li do
            link_to(f, admin_day_of_flight_path(f))
          end
        end
      end
      ul "Last 5 Vets" do
        Veteran.order(created_at: 'DESC').take(5).each do |vet|
          li do
            link_to(vet.full_name + (vet.applied_online ? " (applied online)".html_safe : " (admin entered)") , admin_veteran_path(vet))
          end
        end
      end
    end
  end

  sidebar :help do
    div do
      span do
        "TODO: Link to Documentation"
      end
    end
  end


  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    columns do
      column do
        panel "Upcoming Flight Statistics" do
          div id: "chart_flight_branches"
        end
      end
      column do
        panel "System Statistics" do
          div id: "chart_application_by_month"
        end
        # Let's do Veterans, Guardian, Volunteer applications here in a combo chart
        # https://google-developers.appspot.com/chart/interactive/docs/gallery/combochart
      end
    end
  end # content
end
# :nocov:
