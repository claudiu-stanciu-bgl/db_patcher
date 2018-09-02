
DROP TABLE  model.Account_Created CASCADE;
DROP TABLE  model.Authorization_Granted CASCADE;
DROP TABLE  model.Context_Created CASCADE;
DROP TABLE  model.Variant_Assigned CASCADE;
DROP TABLE  model.Variant_Created CASCADE;
DROP TABLE  model.Variant_Exposed CASCADE;
DROP TABLE  model.Contact_Preferences_Specified CASCADE;
DROP TABLE  model.sales CASCADE;
DROP TABLE  model.fields CASCADE;
DROP TABLE  model.visits CASCADE;
DROP TABLE  model.account_initial_password_set CASCADE;
DROP TABLE  model.visits_v7 CASCADE;
DROP TABLE  model.visitlog CASCADE;
DROP TABLE  model.url CASCADE;
DROP TABLE  model.promotions CASCADE;
DROP TABLE  model.goals CASCADE;
DROP TABLE  model.clicks  CASCADE;
DROP TABLE  model.confirmed_sale_associated_enquiries CASCADE;
DROP TABLE  model.confirmed_sale_status_history CASCADE;
DROP TABLE  model.confirmed_sale_recorded CASCADE;
DROP TABLE  model.Car_Convictions CASCADE;
DROP TABLE  model.Car_Modifications CASCADE;
DROP TABLE  model.enquiry_details_car_person CASCADE;
DROP TABLE  model.Car_Claims CASCADE;
DROP TABLE  model.Enquiry_Details CASCADE;
DROP TABLE  model.Enquiry_Request CASCADE;
DROP TABLE  model.Enquiry_Results CASCADE;
DROP TABLE  model.Enquiry_Results_Display CASCADE;
DROP TABLE  model.Price_Interaction CASCADE;
DROP TABLE  model.Enquiry_Details_Bike CASCADE;
DROP TABLE  model.Enquiry_Details_Home CASCADE;
DROP TABLE  model.Enquiry_Details_Car CASCADE;
DROP TABLE  model.Enquiry_Details_Pet CASCADE;
DROP TABLE  model.Enquiry_Details_Energy CASCADE;
DROP TABLE  model.cinema CASCADE;
DROP TABLE  model.claim_order_status_history CASCADE;
DROP TABLE  model.claim CASCADE;
DROP TABLE  model.claim_evidence CASCADE;
DROP TABLE  model.claim_order CASCADE;
DROP TABLE  model.click_through_tracked CASCADE;
DROP TABLE  model.open_more_details_tracked CASCADE;
DROP TABLE  model.movie_membership_code CASCADE;
DROP TABLE  model.movie_membership_status CASCADE;
DROP TABLE  model.Enquiry_Results_Add_On CASCADE;
DROP TABLE  model.Enquiry_Results_Display_Filters CASCADE;
DROP TABLE  model.product_lead CASCADE;
DROP TABLE  model.enquiry_results_energy CASCADE;
DROP TABLE  model.Enquiry_Results_Bike CASCADE;
DROP TABLE  model.Enquiry_Results_Car CASCADE;
DROP TABLE  model.Enquiry_Results_Van CASCADE;
DROP TABLE  model.film CASCADE;
DROP TABLE  model.Enquiry_Results_Home CASCADE;
DROP TABLE  model.Home_Claims CASCADE;
DROP TABLE  model.Home_Specified_Items CASCADE;
DROP TABLE  model.brand_panel CASCADE;
DROP TABLE  model.enquiry_details_life CASCADE;
DROP TABLE  model.life_person CASCADE;
DROP TABLE  model.enquiry_results_life CASCADE;
DROP TABLE  model.customer_information_log CASCADE;
DROP TABLE  model.enquiry_results_money CASCADE;
DROP TABLE  model.Bike_Additional_Riders CASCADE;
DROP TABLE  model.Bike_Convictions CASCADE;
DROP TABLE  model.Bike_Modifications CASCADE;
DROP TABLE  model.Bike_Claims CASCADE;
DROP TABLE  model.enquiry_details_van_person CASCADE;
DROP TABLE  model.RPC_Customer_Product CASCADE;
DROP TABLE  model.partner_start_visit_tracked CASCADE;
DROP TABLE  model.partner_interaction_tracked CASCADE;
DROP TABLE  model.partner_sale_completion_tracked CASCADE;
DROP TABLE  model.Enquiry_Results_Travel CASCADE;
DROP TABLE  model.Enquiry_Details_Travel CASCADE;
DROP TABLE  model.Travel_Travellers CASCADE;
DROP TABLE  model.Travel_Destination CASCADE;
DROP TABLE  model.enquiry_details_van CASCADE;
DROP TABLE  model.Van_Convictions CASCADE;
DROP TABLE  model.Van_Modifications CASCADE;
DROP TABLE  model.Van_Claims CASCADE;
DROP TABLE  model.celebrus_clicks CASCADE;
DROP TABLE  model.celebrus_cookie CASCADE;
DROP TABLE  model.celebrus_fields CASCADE;
DROP TABLE  model.celebrus_goals CASCADE;
DROP TABLE  model.celebrus_promotions CASCADE;
DROP TABLE  model.celebrus_url CASCADE;
DROP TABLE  model.celebrus_visitlog CASCADE;
DROP TABLE  model.celebrus_visits CASCADE;
DROP TABLE  materialised.enquiry CASCADE;
DROP TABLE  materialised.interaction CASCADE;
DROP TABLE  materialised.policy CASCADE;
DROP TABLE  materialised.policy_home CASCADE;
DROP TABLE  materialised.policy_motor CASCADE;
DROP TABLE  materialised.policy_pet CASCADE;
DROP TABLE  materialised.email CASCADE;
DROP TABLE  materialised.customer CASCADE;
DROP TABLE  materialised.convictions CASCADE;
DROP TABLE  materialised.claims CASCADE;
DROP TABLE  materialised.addon_prices CASCADE;
DROP TABLE  materialised.addon_interactions CASCADE;
DROP TABLE  materialised.price CASCADE;
DROP TABLE  journey_mart.enquiry CASCADE;
DROP TABLE  journey_mart.interaction_addon_bridge CASCADE;
DROP TABLE  journey_mart.interaction_price_filter_bridge CASCADE;
DROP TABLE  journey_mart.price_interaction CASCADE;
DROP TABLE  journey_mart.price_result CASCADE;
DROP TABLE  journey_mart.price_result_price_filter_bridge CASCADE;
DROP TABLE  journey_mart.price_results_addon_bridge CASCADE;
DROP TABLE  journey_mart.product_lead CASCADE;
DROP TABLE  journey_mart.quote_summary CASCADE;
DROP TABLE  journey_mart.session CASCADE;
DROP TABLE  journey_mart.brand_summary CASCADE;
DROP TABLE  dim.audit CASCADE;
DROP TABLE  dim.brand CASCADE;
DROP TABLE  dim.Channel CASCADE;
DROP TABLE  dim.partner CASCADE;
DROP TABLE  dim.product CASCADE;
DROP TABLE  dim.Date CASCADE;
DROP TABLE  dim.time CASCADE;
DROP TABLE  dim.addon CASCADE;
DROP TABLE  dim.customer CASCADE;
DROP TABLE  dim.email CASCADE;
DROP TABLE  dim.interaction CASCADE;
DROP TABLE  dim.policy CASCADE;
DROP TABLE  dim.policy_home CASCADE;
DROP TABLE  dim.policy_motor CASCADE;
DROP TABLE  dim.policy_pet CASCADE;
DROP TABLE  dim.price_filter CASCADE;
DROP TABLE  dim.price_status CASCADE;
DROP TABLE  dim.quote_status CASCADE;
DROP TABLE  dim.session CASCADE;
DROP TABLE  crm.dim_email CASCADE;
DROP TABLE  ancillary.master_brand CASCADE;
DROP TABLE  ancillary.master_channel CASCADE;
DROP TABLE  ancillary.master_partner CASCADE;
DROP TABLE  ancillary.master_partner_locations CASCADE;
DROP TABLE  ancillary.master_product CASCADE;
DROP TABLE  ancillary.master_partner_brand_mapping CASCADE;
DROP TABLE  model.person CASCADE;
DROP TABLE  model.address CASCADE;
DROP FUNCTION public.f_uuid(email varchar(MAX));
--


DROP USER model_user;
DROP USER mimi_user;
DROP USER analytics_reader;
DROP USER model_reader;
DROP USER model_loader;

--

DROP SCHEMA ancillary CASCADE;
DROP SCHEMA crm CASCADE;
DROP SCHEMA dim CASCADE;
DROP SCHEMA journey_mart CASCADE;
DROP SCHEMA materialised CASCADE;
DROP SCHEMA mimi CASCADE;
DROP SCHEMA model CASCADE;

--

DROP GROUP batch_users;
