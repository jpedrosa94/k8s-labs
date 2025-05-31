package main

import (
	"testing"
)

func TestResolveContainerName_WithEnvVar(t *testing.T) {
	getenv := func(key string) string {
		if key == "HOSTNAME" {
			return "env-container-name"
		}
		return ""
	}

	result := resolveContainerName(getenv)
	expected := "env-container-name"

	if result != expected {
		t.Errorf("Expected %s, got %s", expected, result)
	}
}

func TestResolveContainerName_Unknown(t *testing.T) {
	getenv := func(key string) string {
		return ""
	}
	result := resolveContainerName(getenv)
	expected := "unknown-container"

	if result != expected {
		t.Errorf("Expected %s, got %s", expected, result)
	}
}
