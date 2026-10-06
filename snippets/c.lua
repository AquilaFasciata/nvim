return {
	s("eprintf", {
		t("fprintf(stderr, "),
		i(1, "FMTSTRING"),
		t(");"),
		i(0),
	}),
}
