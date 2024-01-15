view: hotel_corporative_encrypted {

  sql_table_name: `bi_dataset.VIEW_HOTEL_CORPORATIVE_ENCRYPTED` ;;

  dimension: hotel_corporative {
    type: string
    sql: ${TABLE}.corporative_hotel_code ;;
  }

  dimension: hotel_code {
    type: string
    sql:  ${TABLE}.hotel_code ;;
  }

  dimension: hotel_code_encrypted {
    type: string
    sql:${TABLE}.hotel_code_encrypted ;;
  }

  dimension: corporative_hotel_code_encrypted {
    type: string
    sql: ${TABLE}.corporative_hotel_code_encrypted ;;
  }

}
