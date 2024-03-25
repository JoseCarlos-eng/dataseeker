connection: "google_analytics_storage"

include: "/views/*.view.lkml"


explore: events{}

explore:  parkroyal_costs {}

explore: bookings_google_analytics {
  join:  parkroyal_costs{
    type:left_outer
    relationship: one_to_one
    sql_on: ${bookings_google_analytics.hotel_code} = ${parkroyal_costs.hotel_code} and ${bookings_google_analytics.date_date} = ${parkroyal_costs.date_date};;
  }
}


explore: parkroyal_2024budget_fixed {}
