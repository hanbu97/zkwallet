// This file is part of Substrate.

// Copyright (C) Parity Technologies (UK) Ltd.
// SPDX-License-Identifier: Apache-2.0

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//! Utilities for offchain calls testing.
//!
//! Namely all ExecutionExtensions that allow mocking
//! the extra APIs.

use std::sync::Arc;

use parking_lot::RwLock;

/// Pending request.
#[derive(Debug, Default, PartialEq, Eq)]
pub struct PendingRequest {
    /// HTTP method
    pub method: String,
    /// URI
    pub uri: String,
    /// Encoded Metadata
    pub meta: Vec<u8>,
    /// Request headers
    pub headers: Vec<(String, String)>,
    /// Request body
    pub body: Vec<u8>,
    /// Has the request been sent already.
    pub sent: bool,
    /// Response body
    pub response: Option<Vec<u8>>,
    /// Number of bytes already read from the response body.
    pub read: usize,
    /// Response headers
    pub response_headers: Vec<(String, String)>,
}

/// The internal state of the fake transaction pool.
#[derive(Default)]
pub struct PoolState {
    /// A vector of transactions submitted from the runtime.
    pub transactions: Vec<Vec<u8>>,
}

/// Implementation of transaction pool used for test.
///
/// Note that this implementation does not verify correctness
/// of sent extrinsics. It's meant to be used in contexts
/// where an actual runtime is not known.
///
/// It's advised to write integration tests that include the
/// actual transaction pool to make sure the produced
/// transactions are valid.
#[derive(Default)]
pub struct TestTransactionPoolExt(Arc<RwLock<PoolState>>);
