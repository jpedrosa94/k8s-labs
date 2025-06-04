package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

// getContainerName returns the container name based on environment or file content.
func getContainerName() string {
	return resolveContainerName(os.Getenv)
}

// resolveContainerName is a testable helper that accepts dependency injection.
func resolveContainerName(getenv func(string) string) string {
	if hostname := getenv("HOSTNAME"); hostname != "" {
		return hostname
	}

	return "unknown-container"
}

func handler(w http.ResponseWriter, r *http.Request) {
	containerName := getContainerName()
	fmt.Fprintf(w, "Container TAG: %s\n", containerName)
}

func main() {
	http.HandleFunc("/", handler)

	port := "3000"
	log.Printf("Starting server on port %s...\n", port)
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}
