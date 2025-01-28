require('diffview')

--[[
        Additionally there are mappings for operating directly on the conflict
        markers:
          • `<leader>co`: Choose the OURS version of the conflict.
          • `<leader>ct`: Choose the THEIRS version of the conflict.
          • `<leader>cb`: Choose the BASE version of the conflict.
          • `<leader>ca`: Choose all versions of the conflict (effectively
            just deletes the markers, leaving all the content).
          • `dx`: Choose none of the versions of the conflict (delete the
            conflict region).
View Maps
                                                *diffview-maps-select_next_entry*
<Tab>                   Open the diff for the next file.
                                                *diffview-maps-select_prev_entry*
<S-Tab>                 Open the diff for the previous file.
                                                *diffview-maps-goto_file_edit*
gf                      Open the local version of the file in a different
                        tabpage. This will target your previous (last
                        accessed) tabpage first. If you have no non-diffview
                        tabpages open, the file will open in a new tabpage.
                        See |diffview-file-inference| for details on how the
                        file target is determined.
                                                *diffview-maps-goto_file_split*
<C-w><C-f>              Open the local version of the file in a new split. See
                        |diffview-file-inference| for details on how the
                        file target is determined.
                                                *diffview-maps-goto_file_tab*
<C-w>gf                 Open the local version of the file in a new tabpage.
                        See |diffview-file-inference| for details on how
                        the file target is determined.
                                                *diffview-maps-toggle_files*
<leader>b               Toggle the file panel.
                                                *diffview-maps-focus_files*
<leader>e               Bring focus to the file panel.
                                                *diffview-maps-copy_hash*
y                       Copy the commit hash of the entry under the cursor.

File panel maps
                                                *diffview-maps-toggle_stage_entry*
-                       Stage/unstage the selected file entry.

                                                *diffview-maps-stage_all*
S                       Stage all entries.

                                                *diffview-maps-unstage_all*
U                       Unstage all entries.

                                                *diffview-maps-restore_entry*
X                       Revert the selected file entry to the state from the
                        left side of the diff. This only works if the right
                        side of the diff is showing the local state of the
                        file. A command is echoed that shows how to undo the
                        change. Check |:messages| or |:DiffviewLog| to see it
                        again.

                                                *diffview-maps-refresh_files*
R                       Update the stats and entries in the file list.

<Tab>                   Open the diff for the next file.

<S-Tab>                 Open the diff for the previous file.

<C-w><C-f>              Open the file in a new split in a different tabpage.

<leader>b               Toggle the file panel.

<leader>e               Bring focus to the file panel.

                                                *diffview-maps-file-history-panel*
File history panel maps ~

These mappings are available in the file history panel buffer (the panel
listing the commits).

                                                *diffview-maps-options*
g!                      Open the option panel.

                                                *diffview-maps-open_in_diffview*
<C-d>                   Open the commit entry under the cursor in a Diffview.

                                                *diffview-maps-open_all_folds*
zR                      Open the fold on all commit entries (only when showing
                        history for multiple files).

                                                *diffview-maps-close_all_folds*
zM                      Close the fold on all commit entries (only when showing
                        history for multiple files).

j                       Bring the cursor to the next item.
<Down>

k                       Bring the cursor to the previous item.
<Up>

o                       Open the diff for the selected item.
<CR>
<2-LeftMouse>

<Tab>                   Open the diff for the next item.

<S-Tab>                 Open the diff for the previous item.

<C-w><C-f>              Open the file in a new split in a different tabpage.

<leader>b               Toggle the file history panel.

<leader>e               Bring focus to the file history panel.

                                                *diffview-maps-file-history-option-panel*
File history option panel maps ~

These mappings are available from the file history option panel. The option
panel will allow you to change the flags that will be passed to `git-log`. A
flag can be adjusted either by moving the cursor to its line followed by
pressing <Tab>, or by using the mappings that are shown directly in the
panel, preceding the flags' descriptions.
--]]
