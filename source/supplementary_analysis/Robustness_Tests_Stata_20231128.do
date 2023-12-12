
* Import data
	import delimited "../data/all_reg_vars_mpnet_768_naicsh6_r3.pkl", clear

* Set panel data structure
	xtset gvkey year


*** Set of Control Variables
	global regressors exemplar_similarity category_coherence category_distinctiveness exemplar_typicality total_sales firm_size market_share eps available_slack 			rd_expenditure advertising_expenditure intangible_assets_ratio depreciation_ratio firm_typicality no_segments mergers_expenditure financial_leverage 			sp500_dummy no_analysts_in_industry no_firms_in_industry average_coverage_yearind average_recoms_yearind category_instability industry_hhi exemplar_eps
	

*** Generate interaction terms
	gen interaction_coherence = exemplar_similarity * category_coherence
	gen interaction_distinctiveness = exemplar_similarity * category_distinctiveness
	gen interaction_typicality = exemplar_similarity * exemplar_typicality



*** Three-way Interaction Models

	xtreg analyst_coverage c.exemplar_similarity##c.category_coherence##c.category_distinctiveness $regressors , fe cluster(gvkey)
	outreg2 using "../data/tables/three_way_interaction_results.doc", replace ctitle("Regression Results - threeway interaction") word pvalue noaster dec(3)

	xtreg analyst_recoms c.exemplar_similarity##c.category_coherence##c.category_distinctiveness $regressors , fe


*** Poisson Regression for Models with Coverage as DV

	* Model 1: baseline coverage
	xtpoisson analyst_coverage $regressors, fe vce(robust)
	outreg2 using "../data/tables/poisson_models.doc", replace ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)


	* Model 3: interaction: coverage*coherence
	xtpoisson analyst_coverage interaction_coherence $regressors , fe vce(robust)
	outreg2 using "../data/tables/poisson_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	* Model 5: interaction: coverage*distinctiveness
	xtpoisson analyst_coverage interaction_distinctiveness $regressors , fe vce(robust)
	outreg2 using "../data/tables/poisson_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	* Model 7: interaction: coverage*typicality
	xtpoisson analyst_coverage interaction_typicality $regressors , fe vce(robust)
	outreg2 using "../data/tables/poisson_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)


*** OLS Models with Log of Analyst Coverage

	gen analyst_coverage_log = log(analyst_coverage+1)

	xtreg analyst_coverage_log $regressors, fe cluster(gvkey)
	outreg2 using "../data/tables/analyst_coverage_log.doc", replace ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtreg analyst_coverage_log interaction_coherence $regressors , fe cluster(gvkey)
	outreg2 using "../data/tables/analyst_coverage_log.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtreg analyst_coverage_log interaction_distinctiveness $regressors , fe cluster(gvkey)
	outreg2 using "../data/tables/analyst_coverage_log.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtreg analyst_coverage_log interaction_typicality $regressors , fe cluster(gvkey)
	outreg2 using "../data/tables/analyst_coverage_log.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)


*** GEE Models
	xtgee analyst_coverage $regressors, i(gvkey) family(nbinomial) link(log) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc", replace ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtgee analyst_recoms $regressors, i(gvkey) family(gaussian) link(identity) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtgee analyst_coverage $regressors interaction_coherence, i(gvkey) family(nbinomial) link(log) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtgee analyst_coverage $regressors interaction_distinctiveness, i(gvkey) family(nbinomial) link(log) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)


	xtgee analyst_recoms $regressors interaction_coherence, i(gvkey) family(gaussian) link(identity) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtgee analyst_recoms $regressors interaction_distinctiveness, i(gvkey) family(gaussian) link() corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtgee analyst_coverage $regressors interaction_typicality, i(gvkey) family(nbinomial) link(log) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	xtgee analyst_recoms $regressors interaction_typicality, i(gvkey) family(gaussian) link(identity) corr(exchange) vce(robust)
	outreg2 using "../data/tables/GEE_models.doc",  ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

*** Two Stage Models

	* Create a binary variable for any analyst coverage
	gen covered = analyst_coverage > 0

	* Estimate the probit model for selection into the sample
	probit covered $regressors proximity_financial_centre
	* Generate the predicted z-scores
	predict zhat, xb

	* Generate the inverse Mills ratio
	* Generate the inverse Mills ratio
	gen imr = normalden(zhat)/normal(zhat) if covered == 1


	* Regress the outcome on the regressors and the IMR to account for selection bias
	xtreg analyst_recoms $regressors imr, fe cluster(gvkey)
	outreg2 using "../data/tables/two_stage_models.doc",  replace ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtreg analyst_recoms interaction_coherence $regressors  imr , fe cluster(gvkey)
	outreg2 using "../data/tables/two_stage_models.doc",   ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtreg analyst_recoms interaction_distinctiveness $regressors  imr , fe cluster(gvkey)
	outreg2 using "../data/tables/two_stage_models.doc",   ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)

	xtreg analyst_recoms interaction_typicality $regressors  imr , fe cluster(gvkey)
	outreg2 using "../data/tables/two_stage_models.doc",   ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)
	
*** Models without correlating control variable (either category coherence or exemplar_typicality removed)
	global regressors_nocoherence exemplar_similarity  category_distinctiveness exemplar_typicality total_sales firm_size market_share eps available_slack 					rd_expenditure advertising_expenditure intangible_assets_ratio depreciation_ratio  no_segments mergers_expenditure financial_leverage 					sp500_dummy no_analysts_in_industry no_firms_in_industry average_coverage_yearind average_recoms_yearind category_instability industry_hhi 				exemplar_eps
	
	global regressors_notypicality exemplar_similarity category_coherence category_distinctiveness  total_sales firm_size market_share eps 				available_slack rd_expenditure advertising_expenditure intangible_assets_ratio depreciation_ratio  no_segments mergers_expenditure financial_leverage 			sp500_dummy no_analysts_in_industry no_firms_in_industry average_coverage_yearind average_recoms_yearind category_instability industry_hhi exemplar_eps



	* Model 3: interaction: coverage*coherence
	xtreg analyst_coverage $regressors_notypicality interaction_coherence, fe cluster(gvkey)
	outreg2 using "../data/tables/remove_correlating_var.doc",  replace ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	* Model 4: interaction: recoms*coherence
	xtreg analyst_recoms $regressors_notypicality interaction_coherence, fe cluster(gvkey)
	outreg2 using "../data/tables/remove_correlating_var.doc",   ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)


	* Model 7: interaction: coverage*typicality
	xtreg analyst_coverage $regressors_nocoherence interaction_typicality, fe cluster(gvkey)
	outreg2 using "../data/tables/remove_correlating_var.doc",   ctitle("Analyst Coverage t+1") word pvalue noaster dec(3)

	* Model 8: interaction: recoms*typicality
	xtreg analyst_recoms $regressors_nocoherence interaction_typicality, fe cluster(gvkey)
	outreg2 using "../data/tables/remove_correlating_var.doc",   ctitle("Analyst Recoms t+1") word pvalue noaster dec(3)


		
