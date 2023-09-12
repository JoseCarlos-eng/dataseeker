# The name of this view in Looker is "Z to Delete Acumulado Anual"
view: z_to_delete_acumulado_anual {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bi_dataset.Z_TO_DELETE_ACUMULADO_ANUAL` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Hotel Code" in Explore.

  dimension: hotel_code {
    type: string
    sql: ${TABLE}.hotel_code ;;
  }

  dimension: reservas {
    type: number
    sql: ${TABLE}.Reservas ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_reservas {
    type: sum
    sql: ${reservas} ;;  }
  measure: average_reservas {
    type: average
    sql: ${reservas} ;;  }

  dimension: ventas {
    type: number
    sql: ${TABLE}.Ventas ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }
  measure: count {
    type: count
  }
}
