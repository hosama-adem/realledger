package config

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

// Config holds process settings loaded from the environment.
type Config struct {
	HTTPAddr        string
	DatabaseURL     string
	LogLevel        string
	ShutdownTimeout time.Duration
}

// Load reads settings from the environment. Call after any .env file load.
func Load() (Config, error) {
	cfg := Config{
		HTTPAddr:        getenv("HTTP_ADDR", ":8080"),
		DatabaseURL:     strings.TrimSpace(os.Getenv("DATABASE_URL")),
		LogLevel:        strings.ToLower(getenv("LOG_LEVEL", "info")),
		ShutdownTimeout: 10 * time.Second,
	}

	if raw := strings.TrimSpace(os.Getenv("SHUTDOWN_TIMEOUT_SEC")); raw != "" {
		sec, err := strconv.Atoi(raw)
		if err != nil || sec < 1 {
			return Config{}, fmt.Errorf("SHUTDOWN_TIMEOUT_SEC must be a positive integer")
		}
		cfg.ShutdownTimeout = time.Duration(sec) * time.Second
	}

	if cfg.DatabaseURL == "" {
		return Config{}, fmt.Errorf("DATABASE_URL is required")
	}
	if !strings.HasPrefix(cfg.HTTPAddr, ":") && !strings.Contains(cfg.HTTPAddr, ":") {
		cfg.HTTPAddr = ":" + cfg.HTTPAddr
	}

	switch cfg.LogLevel {
	case "debug", "info", "warn", "error":
	default:
		return Config{}, fmt.Errorf("LOG_LEVEL must be one of debug, info, warn, error")
	}

	return cfg, nil
}

func getenv(key, fallback string) string {
	if v := strings.TrimSpace(os.Getenv(key)); v != "" {
		return v
	}
	return fallback
}
