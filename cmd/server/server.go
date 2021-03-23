package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
)

var version = os.Getenv("VERSION")

type logger struct{}

func (*logger) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "URL: "+r.URL.String())
}

func handleVersion(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, version)
}

func main() {
	port := 8080

	mux := http.NewServeMux()

	mux.Handle("/", &logger{})

	mux.HandleFunc("/version", handleVersion)

	fmt.Printf("Running on version %s", version)
	fmt.Printf("Starting server on port %d", port)

	listenErr := http.ListenAndServe(fmt.Sprintf(":%d", port), mux)

	if listenErr != nil {
		log.Fatal(listenErr)
	}
}
