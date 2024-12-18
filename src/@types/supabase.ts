export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[];

export type Database = {
	public: {
		Tables: {
			account_deletions: {
				Row: {
					id: number;
					when: string | null;
					who: string | null;
					why: string | null;
				};
				Insert: {
					id?: number;
					when?: string | null;
					who?: string | null;
					why?: string | null;
				};
				Update: {
					id?: number;
					when?: string | null;
					who?: string | null;
					why?: string | null;
				};
				Relationships: [];
			};
			health_medicines: {
				Row: {
					amount: string;
					created_at: string;
					created_by: string;
					description: string;
					dose: string;
					health_id: string;
					id: number;
					type: number;
					updated_at: string;
					updated_by: string;
					medication_start: Date;
					medication_end: Date;
				};
				Insert: {
					amount: string;
					created_at?: string;
					created_by: string;
					description: string;
					dose: string;
					health_id: string;
					id?: number;
					type?: number;
					updated_at?: string;
					updated_by: string;
					medication_start: Date;
					medication_end: Date;
				};
				Update: {
					amount?: string;
					created_at?: string;
					created_by?: string;
					description?: string;
					dose?: string;
					health_id?: string;
					id?: number;
					type?: number;
					updated_at?: string;
					updated_by?: string;
					medication_start?: Date;
					medication_end?: Date;
				};
				Relationships: [
					{
						foreignKeyName: "health_medicines_pets_health_id_fk";
						columns: ["health_id"];
						isOneToOne: false;
						referencedRelation: "pets_health";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "health_medicines_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "health_medicines_users_id_fk_2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			health_vaccines: {
				Row: {
					created_at: string | null;
					created_by: string;
					description: string;
					health_id: string;
					id: string;
					updated_at: string;
					updated_by: string;
				};
				Insert: {
					created_at?: string | null;
					created_by: string;
					description: string;
					health_id: string;
					id?: string;
					updated_at?: string;
					updated_by: string;
				};
				Update: {
					created_at?: string | null;
					created_by?: string;
					description?: string;
					health_id?: string;
					id?: string;
					updated_at?: string;
					updated_by?: string;
				};
				Relationships: [
					{
						foreignKeyName: "health_vaccines_pets_health_id_fk";
						columns: ["health_id"];
						isOneToOne: false;
						referencedRelation: "pets_health";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "health_vaccines_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "health_vaccines_users_id_fk_2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			locale_cities: {
				Row: {
					created_at: string | null;
					id: number;
					name: string | null;
					state_id: number;
				};
				Insert: {
					created_at?: string | null;
					id?: number;
					name?: string | null;
					state_id: number;
				};
				Update: {
					created_at?: string | null;
					id?: number;
					name?: string | null;
					state_id?: number;
				};
				Relationships: [
					{
						foreignKeyName: "locale_cities_state_id_fkey";
						columns: ["state_id"];
						isOneToOne: false;
						referencedRelation: "locale_states";
						referencedColumns: ["id"];
					}
				];
			};
			locale_countries: {
				Row: {
					created_at: string;
					emoji: string | null;
					extras: Json;
					id: number;
					iso: string;
					name: string;
					phone_code: string;
					tz: Json | null;
				};
				Insert: {
					created_at?: string;
					emoji?: string | null;
					extras: Json;
					id?: number;
					iso: string;
					name: string;
					phone_code: string;
					tz?: Json | null;
				};
				Update: {
					created_at?: string;
					emoji?: string | null;
					extras?: Json;
					id?: number;
					iso?: string;
					name?: string;
					phone_code?: string;
					tz?: Json | null;
				};
				Relationships: [];
			};
			locale_states: {
				Row: {
					country_id: number;
					created_at: string | null;
					id: number;
					name: string;
					state_code: string;
					type: string | null;
				};
				Insert: {
					country_id: number;
					created_at?: string | null;
					id?: number;
					name: string;
					state_code: string;
					type?: string | null;
				};
				Update: {
					country_id?: number;
					created_at?: string | null;
					id?: number;
					name?: string;
					state_code?: string;
					type?: string | null;
				};
				Relationships: [
					{
						foreignKeyName: "locale_states_country_id_fkey";
						columns: ["country_id"];
						isOneToOne: false;
						referencedRelation: "locale_countries";
						referencedColumns: ["id"];
					}
				];
			};
			pets: {
				Row: {
					birth_date: string | null;
					breed: string | null;
					breed_id_old: number | null;
					created_at: string | null;
					created_by: string;
					deleted_at: string | null;
					description: string | null;
					gender: number;
					has_stud_book: boolean;
					id: string;
					name: string;
					type: number;
					updated_at: string;
					updated_by: string;
					user_id: string;
				};
				Insert: {
					birth_date?: string | null;
					breed?: string | null;
					breed_id_old?: number | null;
					created_at?: string | null;
					created_by: string;
					deleted_at?: string | null;
					description?: string | null;
					gender: number;
					has_stud_book?: boolean;
					id?: string;
					name: string;
					type?: number;
					updated_at: string;
					updated_by: string;
					user_id: string;
				};
				Update: {
					birth_date?: string | null;
					breed?: string | null;
					breed_id_old?: number | null;
					created_at?: string | null;
					created_by?: string;
					deleted_at?: string | null;
					description?: string | null;
					gender?: number;
					has_stud_book?: boolean;
					id?: string;
					name?: string;
					type?: number;
					updated_at?: string;
					updated_by?: string;
					user_id?: string;
				};
				Relationships: [
					{
						foreignKeyName: "pets_user_id_fkey";
						columns: ["user_id"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_users_id_fk_2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			pets_health: {
				Row: {
					created_at: string;
					created_by: string;
					height: number;
					id: string;
					length: number;
					pet_id: string;
					updated_at: string;
					updated_by: string;
					weight: number;
				};
				Insert: {
					created_at?: string;
					created_by: string;
					height?: number;
					id?: string;
					length?: number;
					pet_id: string;
					updated_at?: string;
					updated_by: string;
					weight?: number;
				};
				Update: {
					created_at?: string;
					created_by?: string;
					height?: number;
					id?: string;
					length?: number;
					pet_id?: string;
					updated_at?: string;
					updated_by?: string;
					weight?: number;
				};
				Relationships: [
					{
						foreignKeyName: "pets_health_pets_id_fk";
						columns: ["pet_id"];
						isOneToOne: false;
						referencedRelation: "pets";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_health_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_health_users_id_fk_2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			pets_reminders: {
				Row: {
					created_at: string;
					created_by: string;
					description: string | null;
					id: string;
					medicine_id: number | null;
					pet_id: string;
					remember_again_in: string | null;
					remember_when: string;
					text: string;
					triggered: boolean;
					updated_at: string | null;
					updated_by?: string;
				};
				Insert: {
					created_at?: string;
					created_by?: string;
					description?: string | null;
					id?: string;
					medicine_id?: number | null;
					pet_id: string;
					remember_again_in?: string | null;
					remember_when: string;
					text: string;
					triggered?: boolean;
					updated_at?: string | null;
					updated_by?: string;
				};
				Update: {
					created_at?: string;
					created_by?: string;
					description?: string | null;
					id?: string;
					medicine_id?: number | null;
					pet_id?: string;
					remember_again_in?: string | null;
					remember_when?: string;
					text?: string;
					triggered?: boolean;
					updated_at?: string | null;
					updated_by?: string;
				};
				Relationships: [
					{
						foreignKeyName: "pets_reminders_health_medicines_id_fk";
						columns: ["medicine_id"];
						isOneToOne: false;
						referencedRelation: "health_medicines";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_reminders_pets_id_fk";
						columns: ["pet_id"];
						isOneToOne: false;
						referencedRelation: "pets";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_reminders_profiles_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_reminders_profiles_id_fk2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					}
				];
			};
			pets_walks: {
				Row: {
					created_at: string;
					created_by: string;
					date_end: string | null;
					date_start: string;
					distance: Json;
					duration: number;
					id: string;
					pet_id: string;
					total_distance: Record<string, any>;
					updated_at: string;
					updated_by: string;
				};
				Insert: {
					created_at?: string;
					created_by: string;
					date_end?: string | null;
					date_start?: string;
					distance: Json;
					duration?: number;
					id?: string;
					pet_id: string;
					total_distance?: Json;
					updated_at?: string;
					updated_by: string;
				};
				Update: {
					created_at?: string;
					created_by?: string;
					date_end?: string | null;
					date_start?: string;
					distance?: Json;
					duration?: number;
					id?: string;
					pet_id?: string;
					total_distance?: Json;
					updated_at?: string;
					updated_by?: string;
				};
				Relationships: [
					{
						foreignKeyName: "pets_walks_pet_id_fkey";
						columns: ["pet_id"];
						isOneToOne: false;
						referencedRelation: "pets";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_walks_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "pets_walks_users_id_fk_2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			places: {
				Row: {
					address_cep: string;
					address_district: string;
					address_location: string;
					address_number: number;
					address_phone: string | null;
					address_street: string;
					approved: boolean;
					coordinates: number[];
					created_at: string;
					description: string | null;
					id: string;
					maps_url: string;
					name: string;
					place_type: string;
					requested_by: string;
				};
				Insert: {
					address_cep: string;
					address_district: string;
					address_location: string;
					address_number: number;
					address_phone?: string | null;
					address_street: string;
					approved?: boolean;
					coordinates: number[];
					created_at?: string;
					description?: string | null;
					id?: string;
					maps_url: string;
					name: string;
					place_type: string;
					requested_by: string;
				};
				Update: {
					address_cep?: string;
					address_district?: string;
					address_location?: string;
					address_number?: number;
					address_phone?: string | null;
					address_street?: string;
					approved?: boolean;
					coordinates?: number[];
					created_at?: string;
					description?: string | null;
					id?: string;
					maps_url?: string;
					name?: string;
					place_type?: string;
					requested_by?: string;
				};
				Relationships: [
					{
						foreignKeyName: "places_requested_by_fkey";
						columns: ["requested_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			profiles: {
				Row: {
					address: Json | null;
					avatar_url: string | null;
					birth_date: string;
					completed: boolean;
					created_at: string | null;
					disabled: boolean;
					full_name: string | null;
					gender: number;
					id: string;
					phones: Json | null;
					private: boolean;
					pronouns: number | null;
					settings: Json | null;
					updated_at: string | null;
					user_name: string | null;
					verified: boolean;
				};
				Insert: {
					address?: Json | null;
					avatar_url?: string | null;
					birth_date: string;
					completed?: boolean;
					created_at?: string | null;
					disabled?: boolean;
					full_name?: string | null;
					gender: number;
					id: string;
					phones?: Json | null;
					private?: boolean;
					pronouns?: number | null;
					settings?: Json | null;
					updated_at?: string | null;
					user_name?: string | null;
					verified?: boolean;
				};
				Update: {
					address?: Json | null;
					avatar_url?: string | null;
					birth_date?: string;
					completed?: boolean;
					created_at?: string | null;
					disabled?: boolean;
					full_name?: string | null;
					gender?: number;
					id?: string;
					phones?: Json | null;
					private?: boolean;
					pronouns?: number | null;
					settings?: Json | null;
					updated_at?: string | null;
					user_name?: string | null;
					verified?: boolean;
				};
				Relationships: [
					{
						foreignKeyName: "profiles_id_fkey";
						columns: ["id"];
						isOneToOne: true;
						referencedRelation: "users";
						referencedColumns: ["id"];
					}
				];
			};
			user_follows: {
				Row: {
					accepted: boolean | null;
					created_at: string;
					id: number;
					notification_sent: boolean | null;
					requested: string | null;
					requester: string;
					updated_at: string;
				};
				Insert: {
					accepted?: boolean | null;
					created_at: string;
					id?: number;
					notification_sent?: boolean | null;
					requested?: string | null;
					requester: string;
					updated_at: string;
				};
				Update: {
					accepted?: boolean | null;
					created_at?: string;
					id?: number;
					notification_sent?: boolean | null;
					requested?: string | null;
					requester?: string;
					updated_at?: string;
				};
				Relationships: [
					{
						foreignKeyName: "user_follows_requested_fkey";
						columns: ["requested"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "user_follows_requester_fkey";
						columns: ["requester"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					}
				];
			};
			vaccines_doses: {
				Row: {
					created_at: string;
					created_by: string;
					dose: number | null;
					id: string;
					injection_date: string | null;
					updated_at: string;
					updated_by: string;
					vaccine_id: string;
				};
				Insert: {
					created_at?: string;
					created_by: string;
					dose?: number | null;
					id?: string;
					injection_date?: string | null;
					updated_at?: string;
					updated_by: string;
					vaccine_id: string;
				};
				Update: {
					created_at?: string;
					created_by?: string;
					dose?: number | null;
					id?: string;
					injection_date?: string | null;
					updated_at?: string;
					updated_by?: string;
					vaccine_id?: string;
				};
				Relationships: [
					{
						foreignKeyName: "vaccines_doses_users_id_fk";
						columns: ["created_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "vaccines_doses_users_id_fk2";
						columns: ["updated_by"];
						isOneToOne: false;
						referencedRelation: "users";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "vaccines_doses_vaccine_id_fkey";
						columns: ["vaccine_id"];
						isOneToOne: false;
						referencedRelation: "health_vaccines";
						referencedColumns: ["id"];
					}
				];
			};
			walks_likes: {
				Row: {
					created_at: string | null;
					id: string;
					user_id: string | null;
					walk_id: string | null;
				};
				Insert: {
					created_at?: string | null;
					id?: string;
					user_id?: string | null;
					walk_id?: string | null;
				};
				Update: {
					created_at?: string | null;
					id?: string;
					user_id?: string | null;
					walk_id?: string | null;
				};
				Relationships: [
					{
						foreignKeyName: "walks_likes_pets_walks_id_fk";
						columns: ["walk_id"];
						isOneToOne: false;
						referencedRelation: "pets_walks";
						referencedColumns: ["id"];
					},
					{
						foreignKeyName: "walks_likes_profiles_id_fk";
						columns: ["user_id"];
						isOneToOne: false;
						referencedRelation: "profiles";
						referencedColumns: ["id"];
					}
				];
			};
		};
		Views: {
			[_ in never]: never;
		};
		Functions: {
			add_compression_policy: {
				Args: {
					hypertable: unknown;
					compress_after: unknown;
					if_not_exists?: boolean;
					schedule_interval?: unknown;
					initial_start?: string;
					timezone?: string;
				};
				Returns: number;
			};
			add_continuous_aggregate_policy: {
				Args: {
					continuous_aggregate: unknown;
					start_offset: unknown;
					end_offset: unknown;
					schedule_interval: unknown;
					if_not_exists?: boolean;
					initial_start?: string;
					timezone?: string;
				};
				Returns: number;
			};
			add_data_node: {
				Args: {
					node_name: unknown;
					host: string;
					database?: unknown;
					port?: number;
					if_not_exists?: boolean;
					bootstrap?: boolean;
					password?: string;
				};
				Returns: {
					node_name: unknown;
					host: string;
					port: number;
					database: unknown;
					node_created: boolean;
					database_created: boolean;
					extension_created: boolean;
				}[];
			};
			add_dimension: {
				Args: {
					hypertable: unknown;
					column_name: unknown;
					number_partitions?: number;
					chunk_time_interval?: unknown;
					partitioning_func?: unknown;
					if_not_exists?: boolean;
				};
				Returns: {
					dimension_id: number;
					schema_name: unknown;
					table_name: unknown;
					column_name: unknown;
					created: boolean;
				}[];
			};
			add_job: {
				Args: {
					proc: unknown;
					schedule_interval: unknown;
					config?: Json;
					initial_start?: string;
					scheduled?: boolean;
					check_config?: unknown;
					fixed_schedule?: boolean;
					timezone?: string;
				};
				Returns: number;
			};
			add_reorder_policy: {
				Args: {
					hypertable: unknown;
					index_name: unknown;
					if_not_exists?: boolean;
					initial_start?: string;
					timezone?: string;
				};
				Returns: number;
			};
			add_retention_policy: {
				Args: {
					relation: unknown;
					drop_after: unknown;
					if_not_exists?: boolean;
					schedule_interval?: unknown;
					initial_start?: string;
					timezone?: string;
				};
				Returns: number;
			};
			alter_data_node: {
				Args: {
					node_name: unknown;
					host?: string;
					database?: unknown;
					port?: number;
					available?: boolean;
				};
				Returns: {
					node_name: unknown;
					host: string;
					port: number;
					database: unknown;
					available: boolean;
				}[];
			};
			alter_job: {
				Args: {
					job_id: number;
					schedule_interval?: unknown;
					max_runtime?: unknown;
					max_retries?: number;
					retry_period?: unknown;
					scheduled?: boolean;
					config?: Json;
					next_start?: string;
					if_exists?: boolean;
					check_config?: unknown;
				};
				Returns: {
					job_id: number;
					schedule_interval: unknown;
					max_runtime: unknown;
					max_retries: number;
					retry_period: unknown;
					scheduled: boolean;
					config: Json;
					next_start: string;
					check_config: string;
				}[];
			};
			approximate_row_count: {
				Args: {
					relation: unknown;
				};
				Returns: number;
			};
			attach_data_node: {
				Args: {
					node_name: unknown;
					hypertable: unknown;
					if_not_attached?: boolean;
					repartition?: boolean;
				};
				Returns: {
					hypertable_id: number;
					node_hypertable_id: number;
					node_name: unknown;
				}[];
			};
			attach_tablespace: {
				Args: {
					tablespace: unknown;
					hypertable: unknown;
					if_not_attached?: boolean;
				};
				Returns: undefined;
			};
			check_pet_owner: {
				Args: {
					pet_id: string;
					auth_user_id: string;
				};
				Returns: boolean;
			};
			chunk_compression_stats: {
				Args: {
					hypertable: unknown;
				};
				Returns: {
					chunk_schema: unknown;
					chunk_name: unknown;
					compression_status: string;
					before_compression_table_bytes: number;
					before_compression_index_bytes: number;
					before_compression_toast_bytes: number;
					before_compression_total_bytes: number;
					after_compression_table_bytes: number;
					after_compression_index_bytes: number;
					after_compression_toast_bytes: number;
					after_compression_total_bytes: number;
					node_name: unknown;
				}[];
			};
			chunks_detailed_size: {
				Args: {
					hypertable: unknown;
				};
				Returns: {
					chunk_schema: unknown;
					chunk_name: unknown;
					table_bytes: number;
					index_bytes: number;
					toast_bytes: number;
					total_bytes: number;
					node_name: unknown;
				}[];
			};
			compress_chunk: {
				Args: {
					uncompressed_chunk: unknown;
					if_not_compressed?: boolean;
				};
				Returns: unknown;
			};
			create_distributed_hypertable: {
				Args: {
					relation: unknown;
					time_column_name: unknown;
					partitioning_column?: unknown;
					number_partitions?: number;
					associated_schema_name?: unknown;
					associated_table_prefix?: unknown;
					chunk_time_interval?: unknown;
					create_default_indexes?: boolean;
					if_not_exists?: boolean;
					partitioning_func?: unknown;
					migrate_data?: boolean;
					chunk_target_size?: string;
					chunk_sizing_func?: unknown;
					time_partitioning_func?: unknown;
					replication_factor?: number;
					data_nodes?: unknown[];
				};
				Returns: {
					hypertable_id: number;
					schema_name: unknown;
					table_name: unknown;
					created: boolean;
				}[];
			};
			create_distributed_restore_point: {
				Args: {
					name: string;
				};
				Returns: {
					node_name: unknown;
					node_type: string;
					restore_point: unknown;
				}[];
			};
			create_hypertable: {
				Args: {
					relation: unknown;
					time_column_name: unknown;
					partitioning_column?: unknown;
					number_partitions?: number;
					associated_schema_name?: unknown;
					associated_table_prefix?: unknown;
					chunk_time_interval?: unknown;
					create_default_indexes?: boolean;
					if_not_exists?: boolean;
					partitioning_func?: unknown;
					migrate_data?: boolean;
					chunk_target_size?: string;
					chunk_sizing_func?: unknown;
					time_partitioning_func?: unknown;
					replication_factor?: number;
					data_nodes?: unknown[];
					distributed?: boolean;
				};
				Returns: {
					hypertable_id: number;
					schema_name: unknown;
					table_name: unknown;
					created: boolean;
				}[];
			};
			decompress_chunk: {
				Args: {
					uncompressed_chunk: unknown;
					if_compressed?: boolean;
				};
				Returns: unknown;
			};
			delete_data_node: {
				Args: {
					node_name: unknown;
					if_exists?: boolean;
					force?: boolean;
					repartition?: boolean;
					drop_database?: boolean;
				};
				Returns: boolean;
			};
			delete_job: {
				Args: {
					job_id: number;
				};
				Returns: undefined;
			};
			detach_data_node: {
				Args: {
					node_name: unknown;
					hypertable?: unknown;
					if_attached?: boolean;
					force?: boolean;
					repartition?: boolean;
					drop_remote_data?: boolean;
				};
				Returns: number;
			};
			detach_tablespace: {
				Args: {
					tablespace: unknown;
					hypertable?: unknown;
					if_attached?: boolean;
				};
				Returns: number;
			};
			detach_tablespaces: {
				Args: {
					hypertable: unknown;
				};
				Returns: number;
			};
			drop_chunks: {
				Args: {
					relation: unknown;
					older_than?: unknown;
					newer_than?: unknown;
					verbose?: boolean;
				};
				Returns: string[];
			};
			get_pet_user_id: {
				Args: {
					uid: string;
				};
				Returns: {
					row_id: string;
				}[];
			};
			get_telemetry_report: {
				Args: Record<PropertyKey, never>;
				Returns: Json;
			};
			hypertable_compression_stats: {
				Args: {
					hypertable: unknown;
				};
				Returns: {
					total_chunks: number;
					number_compressed_chunks: number;
					before_compression_table_bytes: number;
					before_compression_index_bytes: number;
					before_compression_toast_bytes: number;
					before_compression_total_bytes: number;
					after_compression_table_bytes: number;
					after_compression_index_bytes: number;
					after_compression_toast_bytes: number;
					after_compression_total_bytes: number;
					node_name: unknown;
				}[];
			};
			hypertable_detailed_size: {
				Args: {
					hypertable: unknown;
				};
				Returns: {
					table_bytes: number;
					index_bytes: number;
					toast_bytes: number;
					total_bytes: number;
					node_name: unknown;
				}[];
			};
			hypertable_index_size: {
				Args: {
					index_name: unknown;
				};
				Returns: number;
			};
			hypertable_size: {
				Args: {
					hypertable: unknown;
				};
				Returns: number;
			};
			interpolate:
				| {
						Args: {
							value: number;
							prev?: Record<string, unknown>;
							next?: Record<string, unknown>;
						};
						Returns: number;
				  }
				| {
						Args: {
							value: number;
							prev?: Record<string, unknown>;
							next?: Record<string, unknown>;
						};
						Returns: number;
				  }
				| {
						Args: {
							value: number;
							prev?: Record<string, unknown>;
							next?: Record<string, unknown>;
						};
						Returns: number;
				  }
				| {
						Args: {
							value: number;
							prev?: Record<string, unknown>;
							next?: Record<string, unknown>;
						};
						Returns: number;
				  }
				| {
						Args: {
							value: number;
							prev?: Record<string, unknown>;
							next?: Record<string, unknown>;
						};
						Returns: number;
				  };
			locf: {
				Args: {
					value: unknown;
					prev?: unknown;
					treat_null_as_missing?: boolean;
				};
				Returns: unknown;
			};
			move_chunk: {
				Args: {
					chunk: unknown;
					destination_tablespace: unknown;
					index_destination_tablespace?: unknown;
					reorder_index?: unknown;
					verbose?: boolean;
				};
				Returns: undefined;
			};
			remove_compression_policy: {
				Args: {
					hypertable: unknown;
					if_exists?: boolean;
				};
				Returns: boolean;
			};
			remove_continuous_aggregate_policy: {
				Args: {
					continuous_aggregate: unknown;
					if_not_exists?: boolean;
					if_exists?: boolean;
				};
				Returns: undefined;
			};
			remove_reorder_policy: {
				Args: {
					hypertable: unknown;
					if_exists?: boolean;
				};
				Returns: undefined;
			};
			remove_retention_policy: {
				Args: {
					relation: unknown;
					if_exists?: boolean;
				};
				Returns: undefined;
			};
			reorder_chunk: {
				Args: {
					chunk: unknown;
					index?: unknown;
					verbose?: boolean;
				};
				Returns: undefined;
			};
			set_adaptive_chunking: {
				Args: {
					hypertable: unknown;
					chunk_target_size: string;
				};
				Returns: Record<string, unknown>;
			};
			set_chunk_time_interval: {
				Args: {
					hypertable: unknown;
					chunk_time_interval: unknown;
					dimension_name?: unknown;
				};
				Returns: undefined;
			};
			set_integer_now_func: {
				Args: {
					hypertable: unknown;
					integer_now_func: unknown;
					replace_if_exists?: boolean;
				};
				Returns: undefined;
			};
			set_number_partitions: {
				Args: {
					hypertable: unknown;
					number_partitions: number;
					dimension_name?: unknown;
				};
				Returns: undefined;
			};
			set_replication_factor: {
				Args: {
					hypertable: unknown;
					replication_factor: number;
				};
				Returns: undefined;
			};
			show_chunks: {
				Args: {
					relation: unknown;
					older_than?: unknown;
					newer_than?: unknown;
				};
				Returns: unknown[];
			};
			show_tablespaces: {
				Args: {
					hypertable: unknown;
				};
				Returns: unknown[];
			};
			time_bucket:
				| {
						Args: {
							bucket_width: number;
							ts: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
							offset: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
							offset: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
							offset: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							offset: unknown;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							offset: unknown;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							offset: unknown;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							origin: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							origin: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							origin: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							timezone: string;
							origin?: string;
							offset?: unknown;
						};
						Returns: string;
				  };
			time_bucket_gapfill:
				| {
						Args: {
							bucket_width: number;
							ts: number;
							start?: number;
							finish?: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
							start?: number;
							finish?: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: number;
							ts: number;
							start?: number;
							finish?: number;
						};
						Returns: number;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							start?: string;
							finish?: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							start?: string;
							finish?: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							start?: string;
							finish?: string;
						};
						Returns: string;
				  }
				| {
						Args: {
							bucket_width: unknown;
							ts: string;
							timezone: string;
							start?: string;
							finish?: string;
						};
						Returns: string;
				  };
			timescaledb_fdw_handler: {
				Args: Record<PropertyKey, never>;
				Returns: unknown;
			};
			timescaledb_post_restore: {
				Args: Record<PropertyKey, never>;
				Returns: boolean;
			};
			timescaledb_pre_restore: {
				Args: Record<PropertyKey, never>;
				Returns: boolean;
			};
		};
		Enums: {
			[_ in never]: never;
		};
		CompositeTypes: {
			[_ in never]: never;
		};
	};
};

type PublicSchema = Database[Extract<keyof Database, "public">];

export type Tables<
	PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] & PublicSchema["Views"]) | { schema: keyof Database },
	TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
		? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
				Database[PublicTableNameOrOptions["schema"]]["Views"])
		: never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
	? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
			Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
			Row: infer R;
	  }
		? R
		: never
	: PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] & PublicSchema["Views"])
	? (PublicSchema["Tables"] & PublicSchema["Views"])[PublicTableNameOrOptions] extends {
			Row: infer R;
	  }
		? R
		: never
	: never;

export type TablesInsert<
	PublicTableNameOrOptions extends keyof PublicSchema["Tables"] | { schema: keyof Database },
	TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
		? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
		: never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
	? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
			Insert: infer I;
	  }
		? I
		: never
	: PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
	? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
			Insert: infer I;
	  }
		? I
		: never
	: never;

export type TablesUpdate<
	PublicTableNameOrOptions extends keyof PublicSchema["Tables"] | { schema: keyof Database },
	TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
		? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
		: never = never
> = PublicTableNameOrOptions extends { schema: keyof Database }
	? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
			Update: infer U;
	  }
		? U
		: never
	: PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
	? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
			Update: infer U;
	  }
		? U
		: never
	: never;

export type Enums<
	PublicEnumNameOrOptions extends keyof PublicSchema["Enums"] | { schema: keyof Database },
	EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
		? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
		: never = never
> = PublicEnumNameOrOptions extends { schema: keyof Database }
	? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
	: PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
	? PublicSchema["Enums"][PublicEnumNameOrOptions]
	: never;
