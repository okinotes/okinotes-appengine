package main

import (
	"net/http"

	"github.com/gorilla/mux"

	"github.com/okinotes/okinotes"
	"github.com/okinotes/okinotes/ae"
)

func init() {

	r := mux.NewRouter()
	
	f := ae.AppFactory{}

	//API
	api := r.PathPrefix("/api/").Subrouter()
	err := okinotes.RegisterAPIOnRouter(api, f)
	if err != nil {
		panic(err)
	}

	//Home
	err = okinotes.RegisterPagesOnRouter(r, f)
	if err != nil {
		panic(err)
	}

	http.Handle("/", r)
}
