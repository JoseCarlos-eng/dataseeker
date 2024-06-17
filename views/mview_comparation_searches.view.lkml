view: mview_comparation_searches {
 # The name of this view in Looker is "Mview Busquedas"

  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bi_dataset.MVIEW_COMPARATION_SEARCHES` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account" in Explore.

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: adults1 {
    type: string
    sql: ${TABLE}.adults1 ;;
  }

  dimension: adults2 {
    type: string
    sql: ${TABLE}.adults2 ;;
  }

  dimension: adults3 {
    type: string
    sql: ${TABLE}.adults3 ;;
  }

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agentId ;;
  }

  dimension: babies1 {
    type: string
    sql: ${TABLE}.babies1 ;;
  }

  dimension: babies2 {
    type: string
    sql: ${TABLE}.babies2 ;;
  }

  dimension: babies3 {
    type: string
    sql: ${TABLE}.babies3 ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: day {
    type: string
    sql: ${TABLE}.day ;;
  }

  dimension: end_date {
    type: string
    sql: ${TABLE}.endDate ;;
  }

  dimension: goals {
    type: string
    sql: ${TABLE}.goals ;;
  }

  dimension: hotel_city {
    type: string
    sql: ${TABLE}.HotelCity ;;
  }

  dimension: hotel_code {
    type: string
    sql: ${TABLE}.hotel_code ;;
  }

  dimension: hotel_country {
    type: string
    sql: ${TABLE}.HotelCountry ;;
  }

  dimension: hotel_name {
    type: string
    sql: ${TABLE}.HotelName ;;
  }

  dimension: hotel_state {
    type: string
    sql: ${TABLE}.HotelState ;;
  }

  dimension: hotel_zone {
    type: string
    sql: ${TABLE}.HotelZone ;;
  }

  dimension: kids1 {
    type: string
    sql: ${TABLE}.kids1 ;;
  }

  dimension: kids2 {
    type: string
    sql: ${TABLE}.kids2 ;;
  }

  dimension: kids3 {
    type: string
    sql: ${TABLE}.kids3 ;;
  }

  dimension: num_rooms {
    type: string
    sql: ${TABLE}.numRooms ;;
  }

  dimension: percentage_commission {
    type: string
    sql: ${TABLE}.percentage_commission ;;
  }

  dimension: promocode {
    type: string
    sql: ${TABLE}.promocode ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: partition_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.partitionTimestamp ;;
  }

  dimension: result {
    type: string
    sql: ${TABLE}.result ;;
  }

  dimension: source_fixed {
    type: string
    sql: ${TABLE}.source_fixed ;;
  }

  dimension_group: start_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: cast(${TABLE}.startDate as timestamp) ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.timestamp ;;
  }

  measure: count {
    type: count
    drill_fields: [hotel_name]
  }

  measure: OK{
    type: sum
    sql: CASE
          WHEN ${TABLE}.result ='OK' THEN 1
          ELSE 0
  END ;;
  }

  measure: Restrictions{
    type: sum
    sql: CASE
          WHEN ${TABLE}.result ='RESTRICTIONS' THEN 1
          ELSE 0
  END ;;
  }

  measure: NO_RATE{
    type: sum
    sql: CASE
          WHEN ${TABLE}.result ='NO_RATE' THEN 1
          ELSE 0
  END ;;
  }

  measure:  no_availability{
    type: sum
    sql: CASE
          WHEN ${TABLE}.result ='NO_AVAILABILITY' THEN 1
          ELSE 0
  END ;;
  }
  dimension: nights{
    type: number
    sql: date_diff(cast(${TABLE}.endDate as timestamp), cast(${TABLE}.startDate as timestamp), day) ;;
  }

  dimension: year{
    type: number
    sql:  EXTRACT(YEAR FROM ${TABLE}.timestamp) ;;
  }

  dimension_group: comparation_referenceTimestamp{
    type: time
    sql: CASE
        WHEN TIMESTAMP_ADD(${TABLE}.referenceTimestamp, INTERVAL 365 DAY) > CURRENT_TIMESTAMP() THEN NULL
        ELSE TIMESTAMP_ADD(${TABLE}.referenceTimestamp, INTERVAL 365 DAY)
      END ;;
    timeframes: [raw, time, date, week, month, quarter, year]
  }

  dimension: last_year_searches {
    type: number
    sql: ${TABLE}.last_year_searches ;;
  }

  dimension_group: comparation_startDate{
    type: time
    sql: ${TABLE}.comparation_startDate ;;
    timeframes: [raw, time, date, week, month, month_name, quarter, year]
  }

  dimension_group: comparation_endDate{
    type: time
    sql:  CASE
        WHEN TIMESTAMP_ADD(${TABLE}.endDate, INTERVAL 365 DAY) > CURRENT_TIMESTAMP() THEN NULL
        ELSE TIMESTAMP_ADD(${TABLE}.endDate, INTERVAL 365 DAY)
      END ;;
  }


  dimension_group: comparation_partitiontimestamp_without_future{
    type: time
    sql: ${TABLE}.comparationPartitionTimestampWithoutFuture ;;
    timeframes: [raw, time, date, week, month, quarter, year]
  }

  dimension: occupation {
    type: string
    sql: CONCAT(${adults1},'-',${kids1},'-',${babies1}) ;;
  }

  dimension: source_grouped {
    type: string
    sql: CASE
          WHEN ${TABLE}.agentId LIKE '%agente%' AND ${TABLE}.source_fixed LIKE '%Callcenter%' THEN 'Ring2travel'
          WHEN ${TABLE}.agentId NOT LIKE '%agente%' AND ${TABLE}.source_fixed LIKE '%Callcenter%' THEN 'Callseeker'
          ELSE 'WEB'
        END ;;
  }

  dimension: source_fixed_with_Ring2travel{
    type: string
    sql: CASE
          WHEN ${TABLE}.agent LIKE '%agente%' AND ${TABLE}.agent not LIKE '%-nau%' AND ${TABLE}.source_fixed LIKE '%Callcenter%' THEN 'Ring2travel'
          WHEN ${TABLE}.source_fixed like '%Callcenter%' then 'Callcenter'
          ELSE ${TABLE}.source_fixed
        END ;;
  }

  dimension: full_hotel_country {
    # Nueva dimensión para los nombres completos de los países
    type: string
    sql: CASE
      WHEN ${hotel_country} = 'ES' THEN ' Spain'
      WHEN ${hotel_country} = 'CN' THEN 'China'
      WHEN ${hotel_country} = 'TR' THEN 'Turkey'
      WHEN ${hotel_country} = 'SH' THEN 'Saint Helena'
      WHEN ${hotel_country} = 'TL' THEN 'East Timor'
      WHEN ${hotel_country} = 'VG' THEN 'British Virgin Islands'
      WHEN ${hotel_country} = 'TT' THEN 'Trinidad and Tobago'
      WHEN ${hotel_country} = 'KH' THEN 'Cambodia'
      WHEN ${hotel_country} = 'RE' THEN 'Reunion Island'
      WHEN ${hotel_country} = 'SK' THEN 'Slovakia'
      WHEN ${hotel_country} = 'BH' THEN 'Bahrain'
      WHEN ${hotel_country} = 'GT' THEN 'Guatemala'
      WHEN ${hotel_country} = 'FJ' THEN 'Fiji'
      WHEN ${hotel_country} = 'NZ' THEN 'New Zealand'
      WHEN ${hotel_country} = 'TC' THEN 'Turks and Caicos Islands'
      WHEN ${hotel_country} = 'FO' THEN 'Faroe Islands'
      WHEN ${hotel_country} = 'JE' THEN 'Jersey'
      WHEN ${hotel_country} = 'KZ' THEN 'Kazakhstan'
      WHEN ${hotel_country} = 'TO' THEN 'Tonga'
      WHEN ${hotel_country} = 'TV' THEN 'Tuvalu'
      WHEN ${hotel_country} = 'KE' THEN 'Kenya'
      WHEN ${hotel_country} = 'UM' THEN 'United States Minor Outlying Islands'
      WHEN ${hotel_country} = 'BR' THEN 'Brasil'
      WHEN ${hotel_country} = 'IR' THEN 'Irán'
      WHEN ${hotel_country} = 'AF' THEN 'Afghanistan'
      WHEN ${hotel_country} = 'EC' THEN 'Ecuador'
      WHEN ${hotel_country} = 'CY' THEN 'Cyprus'
      WHEN ${hotel_country} = 'SZ' THEN 'Eswatini'
      WHEN ${hotel_country} = 'FI' THEN 'Finland'
      WHEN ${hotel_country} = 'GN' THEN 'Guinea'
      WHEN ${hotel_country} = 'GY' THEN 'Guyana'
      WHEN ${hotel_country} = 'MF' THEN 'Saint Martin'
      WHEN ${hotel_country} = 'SI' THEN 'Slovenia'
      WHEN ${hotel_country} = 'AO' THEN 'Angola'
      WHEN ${hotel_country} = 'PW' THEN 'Palau'
      WHEN ${hotel_country} = 'DO' THEN 'República Dominicana'
      WHEN ${hotel_country} = 'TM' THEN 'Turkmenistán'
      WHEN ${hotel_country} = 'TN' THEN 'Tunisia'
      WHEN ${hotel_country} = 'UG' THEN 'Uganda'
      WHEN ${hotel_country} = 'BD' THEN 'Bangladesh'
      WHEN ${hotel_country} = 'FR' THEN 'France'
      WHEN ${hotel_country} = 'CZ' THEN 'República Checa'
      WHEN ${hotel_country} = 'ST' THEN 'São Tomé and Príncipe'
      WHEN ${hotel_country} = 'OM' THEN 'Omán'
      WHEN ${hotel_country} = 'ZW' THEN 'Zimbabwe'
      WHEN ${hotel_country} = 'PF' THEN 'French Polynesia'
      WHEN ${hotel_country} = 'A1' THEN 'Anonymous Proxy'
      WHEN ${hotel_country} = 'LY' THEN 'Libia'
      WHEN ${hotel_country} = 'BM' THEN 'Bermudas'
      WHEN ${hotel_country} = 'TJ' THEN 'Tajikistan'
      WHEN ${hotel_country} = 'PT' THEN 'Portugal'
      WHEN ${hotel_country} = 'CA' THEN 'Canadá'
      WHEN ${hotel_country} = 'MC' THEN 'Mónaco'
      WHEN ${hotel_country} = 'UZ' THEN 'Uzbekistán'
      WHEN ${hotel_country} = 'SR' THEN 'Surinam'
      WHEN ${hotel_country} = 'GB' THEN 'United Kingdom'
      WHEN ${hotel_country} = 'EG' THEN 'Egipto'
      WHEN ${hotel_country} = 'PM' THEN 'Saint Pierre and Miquelon'
      WHEN ${hotel_country} = 'VN' THEN 'Vietnam'
      WHEN ${hotel_country} = 'SG' THEN 'Singapore'
      WHEN ${hotel_country} = 'SJ' THEN 'Svalbard and Jan Mayen'
      WHEN ${hotel_country} = 'AQ' THEN 'Antarctica'
      WHEN ${hotel_country} = 'IS' THEN 'Iceland'
      WHEN ${hotel_country} = 'GL' THEN 'Greenland'
      WHEN ${hotel_country} = 'YT' THEN 'Mayotte'
      WHEN ${hotel_country} = 'NL' THEN 'Netherlands'
      WHEN ${hotel_country} = 'US' THEN 'United States'
      WHEN ${hotel_country} = 'CH' THEN 'Switzerland'
      WHEN ${hotel_country} = 'MZ' THEN 'Mozambique'
      WHEN ${hotel_country} = 'KR' THEN 'South Korea'
      WHEN ${hotel_country} = 'MD' THEN 'Moldova'
      WHEN ${hotel_country} = 'TZ' THEN 'Tanzania'
      WHEN ${hotel_country} = 'FM' THEN 'Micronesia'
      WHEN ${hotel_country} = 'RW' THEN 'Rwanda'
      WHEN ${hotel_country} = 'UY' THEN 'Uruguay'
      WHEN ${hotel_country} = 'BZ' THEN 'Belize'
      WHEN ${hotel_country} = 'LT' THEN 'Lithuania'
      WHEN ${hotel_country} = 'DJ' THEN 'Djibouti'
      WHEN ${hotel_country} = 'CC' THEN 'Cocos Islands'
      WHEN ${hotel_country} = 'ZA' THEN 'South Africa'
      WHEN ${hotel_country} = 'DE' THEN 'Germany'
      WHEN ${hotel_country} = 'GE' THEN 'Georgia'
      WHEN ${hotel_country} = 'AR' THEN 'Argentina'
      WHEN ${hotel_country} = 'TD' THEN 'Chad'
      WHEN ${hotel_country} = 'PT' THEN 'Portugal'
      WHEN ${hotel_country} = 'CU' THEN 'Cuba'
      WHEN ${hotel_country} = 'CG' THEN 'Congo'
      WHEN ${hotel_country} = 'BA' THEN 'Bosnia and Herzegovina'
      WHEN ${hotel_country} = 'US' THEN 'United States'
      WHEN ${hotel_country} = 'BJ' THEN 'Benin'
      WHEN ${hotel_country} = 'HK' THEN 'Hong Kong'
      WHEN ${hotel_country} = 'HM' THEN 'Heard Island and McDonald Islands'
      WHEN ${hotel_country} = 'GI' THEN 'Gibraltar'
      WHEN ${hotel_country} = 'MG' THEN 'Madagascar'
      WHEN ${hotel_country} = 'FR' THEN 'France'
      WHEN ${hotel_country} = 'MQ' THEN 'Martinique'
      WHEN ${hotel_country} = 'MA' THEN 'Morocco'
      WHEN ${hotel_country} = 'AU' THEN 'Australia'
      WHEN ${hotel_country} = 'BS' THEN 'Bahamas'
      WHEN ${hotel_country} = 'LC' THEN 'Saint Lucia'
      WHEN ${hotel_country} = 'SV' THEN 'El Salvador'
      WHEN ${hotel_country} = 'CV' THEN 'Cabo Verde'
      WHEN ${hotel_country} = 'KG' THEN 'Kyrgyzstan'
      WHEN ${hotel_country} = 'ML' THEN 'Mali'
      WHEN ${hotel_country} = 'MV' THEN 'Maldives'
      WHEN ${hotel_country} = 'BI' THEN 'Burundi'
      WHEN ${hotel_country} = 'KP' THEN 'North Korea'
      WHEN ${hotel_country} = 'GF' THEN 'French Guiana'
      WHEN ${hotel_country} = 'DK' THEN 'Denmark'
      WHEN ${hotel_country} = 'GD' THEN 'Grenada'
      WHEN ${hotel_country} = 'CF' THEN 'Central African Republic'
      WHEN ${hotel_country} = 'JM' THEN 'Jamaica'
      WHEN ${hotel_country} = 'PR' THEN 'Puerto Rico'
      WHEN ${hotel_country} = 'PY' THEN 'Paraguay'
      WHEN ${hotel_country} = 'CK' THEN 'Cook Islands'
      WHEN ${hotel_country} = 'CI' THEN 'Ivory Coast'
      WHEN ${hotel_country} = 'ME' THEN 'Montenegro'
      WHEN ${hotel_country} = 'PT' THEN 'Portugal'
      WHEN ${hotel_country} = 'JP' THEN 'Japan'
      WHEN ${hotel_country} = 'MU' THEN 'Mauritius'
      WHEN ${hotel_country} = 'IQ' THEN 'Iraq'
      WHEN ${hotel_country} = 'BE' THEN 'Belgium'
      WHEN ${hotel_country} = 'NO' THEN 'Norway'
      WHEN ${hotel_country} = 'SC' THEN 'Seychelles'
      WHEN ${hotel_country} = 'GQ' THEN 'Equatorial Guinea'
      WHEN ${hotel_country} = 'AL' THEN 'Albania'
      WHEN ${hotel_country} = 'MK' THEN 'North Macedonia'
      WHEN ${hotel_country} = 'YE' THEN 'Yemen'
      WHEN ${hotel_country} = 'GA' THEN 'Gabon'
      WHEN ${hotel_country} = 'LB' THEN 'Lebanon'
      WHEN ${hotel_country} = 'MR' THEN 'Mauritania'
      WHEN ${hotel_country} = 'SM' THEN 'San Marino'
      WHEN ${hotel_country} = 'VA' THEN 'Vatican City'
      WHEN ${hotel_country} = 'SA' THEN 'Saudi Arabia'
      WHEN ${hotel_country} = 'AN' THEN 'Netherlands Antilles'
      WHEN ${hotel_country} = 'CX' THEN 'Christmas Island'
      WHEN ${hotel_country} = 'KY' THEN 'Cayman Islands'
      WHEN ${hotel_country} = 'SE' THEN 'Sweden'
      WHEN ${hotel_country} = 'TW' THEN 'Taiwan'
      WHEN ${hotel_country} = 'NI' THEN 'Nicaragua'
      WHEN ${hotel_country} = 'UA' THEN 'Ukraine'
      WHEN ${hotel_country} = 'CA' THEN 'Canada'
      WHEN ${hotel_country} = 'ER' THEN 'Eritrea'
      WHEN ${hotel_country} = 'CW' THEN 'Curaçao'
      WHEN ${hotel_country} = 'BW' THEN 'Botswana'
      WHEN ${hotel_country} = 'GH' THEN 'Ghana'
      WHEN ${hotel_country} = 'AD' THEN 'Andorra'
      WHEN ${hotel_country} = 'MO' THEN 'Macao'
      WHEN ${hotel_country} = 'IE' THEN 'Ireland'
      WHEN ${hotel_country} = 'IT' THEN 'Italy'
      WHEN ${hotel_country} = 'PA' THEN 'Panama'
      WHEN ${hotel_country} = 'PN' THEN 'Pitcairn'
      WHEN ${hotel_country} = 'IM' THEN 'Isle of Man'
      WHEN ${hotel_country} = 'MY' THEN 'Malaysia'
      WHEN ${hotel_country} = 'MN' THEN 'Mongolia'
      WHEN ${hotel_country} = 'GP' THEN 'Guadeloupe'
      WHEN ${hotel_country} = 'LR' THEN 'Liberia'
      WHEN ${hotel_country} = 'P' THEN 'Pakistan'
      WHEN ${hotel_country} = 'MX' THEN 'Mexico'
      WHEN ${hotel_country} = 'NP' THEN 'Nepal'
      WHEN ${hotel_country} = 'ES' THEN 'Spain'
      WHEN ${hotel_country} = 'ET' THEN 'Ethiopia'
      WHEN ${hotel_country} = 'CS' THEN 'Serbia and Montenegro'
      WHEN ${hotel_country} = 'BF' THEN 'Burkina Faso'
      WHEN ${hotel_country} = 'AS' THEN 'American Samoa'
      WHEN ${hotel_country} = 'VI' THEN 'U.S. Virgin Islands'
      WHEN ${hotel_country} = 'AT' THEN 'Austria'
      WHEN ${hotel_country} = 'MT' THEN 'Malta'
      WHEN ${hotel_country} = 'SO' THEN 'Somalia'
      WHEN ${hotel_country} = 'RO' THEN 'Romania'
      WHEN ${hotel_country} = 'KW' THEN 'Kuwait'
      WHEN ${hotel_country} = 'VE' THEN 'Venezuela'
      WHEN ${hotel_country} = 'CM' THEN 'Cameroon'
      WHEN ${hotel_country} = 'MH' THEN 'Marshall Islands'
      WHEN ${hotel_country} = 'AP' THEN 'Hong Kong SAR China'
      WHEN ${hotel_country} = 'BO' THEN 'Bolivia'
      WHEN ${hotel_country} = 'EH' THEN 'Western Sahara'
      WHEN ${hotel_country} = 'NR' THEN 'Nauru'
      WHEN ${hotel_country} = 'MM' THEN 'Myanmar'
      WHEN ${hotel_country} = 'BG' THEN 'Bulgaria'
      WHEN ${hotel_country} = 'VU' THEN 'Vanuatu'
      WHEN ${hotel_country} = 'EE' THEN 'Estonia'
      WHEN ${hotel_country} = 'AI' THEN 'Anguilla'
      WHEN ${hotel_country} = 'SX' THEN 'Sint Maarten'
      WHEN ${hotel_country} = 'FR' THEN 'France'
      WHEN ${hotel_country} = 'AM' THEN 'Armenia'
      WHEN ${hotel_country} = 'AZ' THEN 'Azerbaijan'
      WHEN ${hotel_country} = 'PH' THEN 'Philippines'
      WHEN ${hotel_country} = 'HR' THEN 'Croatia'
      WHEN ${hotel_country} = 'LU' THEN 'Luxembourg'
      WHEN ${hotel_country} = 'NG' THEN 'Nigeria'
      WHEN ${hotel_country} = 'KM' THEN 'Comoros'
      WHEN ${hotel_country} = 'LK' THEN 'Sri Lanka'
      WHEN ${hotel_country} = 'DK' THEN 'Denmark'
      WHEN ${hotel_country} = 'LV' THEN 'Latvia'
      WHEN ${hotel_country} = 'CO' THEN 'Colombia'
      WHEN ${hotel_country} = 'RU' THEN 'Russia'
      WHEN ${hotel_country} = 'RS' THEN 'Serbia'
      WHEN ${hotel_country} = 'ZM' THEN 'Zambia'
      WHEN ${hotel_country} = 'KI' THEN 'Kiribati'
      WHEN ${hotel_country} = 'AG' THEN 'Antigua and Barbuda'
      WHEN ${hotel_country} = 'CL' THEN 'Chile'
      WHEN ${hotel_country} = 'ID' THEN 'Indonesia'
      WHEN ${hotel_country} = 'MS' THEN 'Montserrat'
      WHEN ${hotel_country} = 'MW' THEN 'Malawi'
      WHEN ${hotel_country} = 'IN' THEN 'India'
      WHEN ${hotel_country} = 'PE' THEN 'Peru'
      WHEN ${hotel_country} = 'DZ' THEN 'Algeria'
      WHEN ${hotel_country} = 'NA' THEN 'Namibia'
      WHEN ${hotel_country} = 'BN' THEN 'Brunei'
      WHEN ${hotel_country} = 'CD' THEN 'Democratic Republic of the Congo'
      WHEN ${hotel_country} = 'MX' THEN 'Mexico'
      WHEN ${hotel_country} = 'AE' THEN 'United Arab Emirates'
      WHEN ${hotel_country} = 'BY' THEN 'Belarus'
      WHEN ${hotel_country} = 'DM' THEN 'Dominica'
      WHEN ${hotel_country} = 'SY' THEN 'Syria'
      WHEN ${hotel_country} = 'EU' THEN 'European Union'
      WHEN ${hotel_country} = 'GU' THEN 'Guam'
      WHEN ${hotel_country} = 'QA' THEN 'Qatar'
      WHEN ${hotel_country} = 'BB' THEN 'Barbados'
      WHEN ${hotel_country} = 'SB' THEN 'Solomon Islands'
      WHEN ${hotel_country} = 'GR' THEN 'Greece'
      WHEN ${hotel_country} = 'JO' THEN 'Jordan'
      WHEN ${hotel_country} = 'FK' THEN 'Falkland Islands'
      WHEN ${hotel_country} = 'AW' THEN 'Aruba'
      WHEN ${hotel_country} = 'LI' THEN 'Liechtenstein'
      WHEN ${hotel_country} = 'NE' THEN 'Niger'
      WHEN ${hotel_country} = 'GS' THEN 'South Georgia and the South Sandwich Islands'
      WHEN ${hotel_country} = 'VC' THEN 'Saint Vincent and the Grenadines'
      WHEN ${hotel_country} = 'GG' THEN 'Guernsey'
      WHEN ${hotel_country} = 'DE' THEN 'Germany'
      WHEN ${hotel_country} = 'GW' THEN 'Guinea-Bissau'
      WHEN ${hotel_country} = 'SN' THEN 'Senegal'
      WHEN ${hotel_country} = 'NC' THEN 'New Caledonia'
      WHEN ${hotel_country} = 'HT' THEN 'Haiti'
      WHEN ${hotel_country} = 'PG' THEN 'Papua New Guinea'
      WHEN ${hotel_country} = 'BT' THEN 'Bhutan'
      WHEN ${hotel_country} = 'SD' THEN 'Sudan'
      WHEN ${hotel_country} = 'CR' THEN 'Costa Rica'
      WHEN ${hotel_country} = 'NL' THEN 'Netherlands'
      WHEN ${hotel_country} = 'WS' THEN 'Samoa'
      WHEN ${hotel_country} = 'AX' THEN 'Åland Islands'
      WHEN ${hotel_country} = 'TG' THEN 'Togo'
      WHEN ${hotel_country} = 'GM' THEN 'Gambia'
      WHEN ${hotel_country} = 'IL' THEN 'Israel'
      WHEN ${hotel_country} = 'NF' THEN 'Norfolk Island'
      WHEN ${hotel_country} = 'LS' THEN 'Lesotho'
      WHEN ${hotel_country} = 'PL' THEN 'Poland'
      WHEN ${hotel_country} = 'SL' THEN 'Sierra Leone'
      WHEN ${hotel_country} = 'AF' THEN 'Afghanistan'
      WHEN ${hotel_country} = 'HU' THEN 'Hungary'
      WHEN ${hotel_country} = 'KN' THEN 'Saint Kitts and Nevis'
      WHEN ${hotel_country} = 'LA' THEN 'Laos'
      WHEN ${hotel_country} = 'WF' THEN 'Wallis and Futuna'
      WHEN ${hotel_country} = 'HN' THEN 'Honduras'
      WHEN ${hotel_country} = 'TH' THEN 'Thailand'
      WHEN ${hotel_country} = 'PS' THEN 'Palestinian Territories'
      WHEN ${hotel_country} = 'MP' THEN 'Northern Mariana Islands'
      ELSE ${hotel_country}
    END ;;
  }
  measure: sumatoria {
    type: number
    sql: ${OK}+${Restrictions} ;;
  }



}
