local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
    options = {
        mode    = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        
        close_command        = "Bdelete! %d", 
        right_mouse_command  = "Bdelete! %d",
        left_mouse_command   = "buffer %d", 
        middle_mouse_command = nil, 

        indicator_icon     = "▎",
        buffer_close_icon  = '',
        modified_icon      = "●",
        close_icon         = "",
        left_trunc_marker  = "",
        right_trunc_marker = "",

        max_name_length   = 20,
        max_prefix_length = 20, -- prefix used when a buffer is de-duplicated
        tab_size          = 20,

        diagnostics                  = false, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,

        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },

        color_icons              = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons        = true, -- disable filetype icons for buffers
        show_buffer_close_icons  = true,
        show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon          = false,
        show_tab_indicators      = false,

        separator_style        = "thick", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs   = true,
        always_show_bufferline = true,
    },
}
